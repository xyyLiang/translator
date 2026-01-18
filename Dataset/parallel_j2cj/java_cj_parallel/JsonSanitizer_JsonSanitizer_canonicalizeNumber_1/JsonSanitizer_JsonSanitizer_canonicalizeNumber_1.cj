    private func canonicalizeNumber(sanitizedJson: CharArrayList, sanStart: Int64, sanEnd: Int64): Bool {
        // Now we perform several steps.
        // 1. Convert from scientific notation to regular or vice-versa based on
        //    normalized exponent.
        // 2. Remove trailing zeroes from the fraction and truncate it to 24 digits.
        // 3. Elide the fraction entirely if it is ".0".
        // 4. Convert any 'E' that separates the exponent to lower-case.
        // 5. Elide any minus sign on a zero value.
        // to convert the number to its canonical JS string form.

        // Figure out where the parts of the number start and end.
        let intStart = sanStart + if (sanitizedJson.charAt(sanStart) == '-') {
            1
        } else {
            0
        }
        var intEnd = intStart
        while (intEnd < sanEnd) {
            let ch = sanitizedJson.charAt(intEnd)
            if (!('0' <= ch && ch <= '9')) {
                break
            }
            intEnd++
        }

        let (fractionStart, fractionEnd) = if (intEnd == sanEnd || '.' != sanitizedJson.charAt(intEnd)) {
            (intEnd, intEnd)
        } else {
            let fstart = intEnd + 1
            var fend = fstart
            while (fend < sanEnd) {
                let ch = sanitizedJson.charAt(fend)
                if (!('0' <= ch && ch <= '9')) {
                    break
                }
                fend++
            }
            (fstart, fend)
        }

        let (expStart, expEnd) = if (fractionEnd == sanEnd) {
            (sanEnd, sanEnd)
        } else {
            if (sanitizedJson.charAt(fractionEnd).toAsciiLowerCase() != 'e') {
                throw AssertionError("${sanitizedJson.charAt(fractionEnd).toAsciiLowerCase()} != 'e'")
            }
            var start = if (sanitizedJson.charAt(fractionEnd + 1) == '+') {
                fractionEnd + 2
            } else {
                fractionEnd + 1
            }
            (start, sanEnd)
        }
        
        if (!( intStart      <= intEnd 
            && intEnd        <= fractionStart
            && fractionStart <= fractionEnd
            && fractionEnd   <= expStart
            && expStart      <= expEnd
        )) {
            throw AssertionError("""
                intStart: ${intStart}
                intEnd: ${intEnd}
                fractionStart: ${fractionStart}
                fractionEnd: ${fractionEnd}
                expStart: ${expStart}
                expEnd: ${expEnd}
                """
            )
        }

        let exp = if (expEnd == expStart) {
            0
        } else {
            match(parseInt64(sanitizedJson.substring(expStart, expEnd - expStart))) {
                case Some(val) => val
                case None => return false
            }
        }

        // Numbered Comments below come from the EcmaScript 5 language specification
        // section 9.8.1 : ToString Applied to the Number Type
        // https://es5.github.io/#x9.8.1

        // 5. let n, k, and s be integers such that k >= 1, 10^(k-1) <= s < 10^k, the
        // Number value for s * 10^(n-k) is m, and k is as small as possible.
        // Note that k is the number of digits in the decimal representation of s,
        // that s is not divisible by 10, and that the least significant digit of s
        // is not necessarily uniquely determined by these criteria.
        var n = exp // Exponent
    
        // s, the string of decimal digits in the representation of m are stored in
        // sanitizedJson.substring(intStart).
        // k, the number of digits in s is computed later.

        // Leave only the number representation on the output buffer after intStart.
        // This leaves any sign on the digit per
        // 3. If m is less than zero, return the String concatenation of the
        //    String "-" and ToString(-m).
        var sawDecimal = false
        var zero = true
        var digitOutPos = intStart
        var nZeroesPending = 0
        for (i in intStart..fractionEnd) {
            let ch = sanitizedJson.charAt(i)
            if (ch == '.') {
                sawDecimal = true
                if (zero) {
                    nZeroesPending = 0
                }
                continue
            }

            var digit = ch
            if ((!zero || digit != '0') && !sawDecimal) {
                n++
            }

            if (digit == '0') {
                // Keep track of runs of zeros so that we can take them into account
                // if we later see a non-zero digit.
                nZeroesPending++
            } else {
                if (zero) { // First non-zero digit.
                    // Discard runs of zeroes at the front of the integer part, but
                    // any after the decimal point factor into the exponent, n.
                    if (sawDecimal) {
                        n -= nZeroesPending
                    }
                    nZeroesPending = 0
                }
                zero = false
                while (nZeroesPending != 0 || digit != '\0') {
                    let vdigit: Char
                    if (nZeroesPending == 0) {
                        vdigit = digit
                        digit = '\0'
                    } else {
                        vdigit = '0'
                        nZeroesPending--
                    }

                    // TODO: limit s to 21 digits?
                    sanitizedJson.setCharAt(digitOutPos, vdigit)
                    digitOutPos++
                }
            }
        }
        sanitizedJson.removeFromIndex(digitOutPos)

        // Number of digits in decimal representation of s.
        let k = digitOutPos - intStart

        // Now we have computed n, k, and s as defined above.  Time to add decimal
        // points, exponents, and leading zeroes per the rest of the JS number
        // formatting specification.

        if (zero) { // There are no non-zero decimal digits.
            // 2. If m is +0 or -0, return the String "0".
            sanitizedJson.removeFromIndex(sanStart) // Elide any sign.
            sanitizedJson.append('0')
            return true
        }

        // 6. If k <= n <= 21, return the String consisting of the k digits of the
        // decimal representation of s (in order, with no leading zeroes),
        // followed by n-k occurrences of the character '0'.

        if (k <= n && n <= 21) {
            for (i in k..n) {
                sanitizedJson.append('0')
            }
            // 7. If 0 < n <= 21, return the String consisting of the most significant n
            // digits of the decimal representation of s, followed by a decimal point
            // '.', followed by the remaining k-n digits of the decimal representation
            // of s.
        } else if (0 < n && n <= 21) {
            sanitizedJson.insert(intStart + n, '.')

            // 8. If -6 < n <= 0, return the String consisting of the character '0',
            // followed by a decimal point '.', followed by -n occurrences of the
            // character '0', followed by the k digits of the decimal representation of
            // s.
        } else if (-6 < n && n <= 0) {
            sanitizedJson.insert(intStart, "0.000000".substring(0, 2 - n))

        } else {

            // 9. Otherwise, if k = 1, return the String consisting of the single
            // digit of s, followed by lowercase character 'e', followed by a plus
            // sign '+' or minus sign '-' according to whether n-1 is positive or
            // negative, followed by the decimal representation of the integer
            // abs(n-1) (with no leading zeros).
            if (k == 1) {
                // Sole digit already on sanitizedJson.

                // 10. Return the String consisting of the most significant digit of the
                // decimal representation of s, followed by a decimal point '.', followed
                // by the remaining k-1 digits of the decimal representation of s,
                // followed by the lowercase character 'e', followed by a plus sign '+'
                // or minus sign '-' according to whether n-1 is positive or negative,
                // followed by the decimal representation of the integer abs(n-1) (with
                // no leading zeros).
            } else {
                sanitizedJson.insert(intStart + 1, '.')
            }
            let nLess1 = n - 1
            sanitizedJson.append('e').append( 
                if (nLess1 < 0) {
                    '-'
                } else {
                    '+'
                }
            ).append(math.abs(nLess1))
        }

        return true
    }