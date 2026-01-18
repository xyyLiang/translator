    private func normalizeNumber(start: Int64, end: Int64): Unit {
        var pos = start
        // Sign
        if (pos < end) {
            match(jsonish.charAt(pos)) {
                case '+' => 
                    elide(pos, pos + 1)
                    pos++
                case '-' => 
                    pos++
                case _ => ()
            }
        }

        // Integer part
        var intEnd = endOfDigitRun(pos, end)
        if (pos == intEnd) { // No empty integer parts allowed in JSON.
            insert(pos, '0')
        } else if ('0' == jsonish.charAt(pos)) {
            var reencoded = false
            var maxDigVal = 0u32 // The value of the max digit
            var probableBase = 10u32 // The base suggested by the prefix
            var firstDigitIndex = -1
            if (intEnd - pos == 1 && intEnd < end && 'x' == jsonish.charAt(intEnd).toAsciiLowerCase()) { // Recode hex.
                probableBase = 16
                firstDigitIndex = intEnd + 1
                intEnd++
                while (intEnd < end) {
                    let ch = UInt32(jsonish.charAt(intEnd))
                    let digVal = if (ORD_0 <= ch && ch <= ORD_9) {
                        ch - ORD_0
                    } else {
                        let lch = ch | 32
                        if (ORD_a <= lch && lch <= ORD_f) {
                            lch - ORD_a + 10
                        } else {
                            break
                        }
                    }
                    maxDigVal = math.max(digVal, maxDigVal)
                    intEnd++
                }
                reencoded = true
            } else if (intEnd - pos > 1) { // Recode octal.
                probableBase = 8
                firstDigitIndex = pos
                for (i in pos..intEnd) {
                    let code = UInt32(jsonish.charAt(i))
                    if (code < ORD_0) {
                        break
                    }
                    let digVal = code - ORD_0
                    maxDigVal = math.max(digVal, maxDigVal)
                }
                reencoded = true
            }
            if (reencoded) {
                // Avoid multiple signs.
                // Putting out the underflowed value is the least bad option.
                elide(pos, intEnd)

                let digits = jsonish.slice(firstDigitIndex, intEnd - firstDigitIndex)

                let nDigits = digits.size()
                let base = if (probableBase > maxDigVal) {
                    probableBase
                } else {
                    if (maxDigVal > 10) {
                        16u32
                    } else {
                        10u32
                    }
                }
                let sanitizedJson = this.sanitizedJson.getOrThrow()
                if (nDigits == 0) {
                    sanitizedJson.append('0')
                } else if (base == 10 && nDigits <= 18) {
                    let value = parseUInt64(String(digits)).getOrThrow()
                    sanitizedJson.append(value)
                } else {
                    let value = reencodeBigInteger(digits, UInt64(base))
                    sanitizedJson.append(value)
                }
            }
        }
        pos = intEnd

        // Optional fraction.
        if (pos < end && jsonish.charAt(pos) == '.') {
            pos++
            let fractionEnd = endOfDigitRun(pos, end)
            if (fractionEnd == pos) {
                insert(pos, '0')
            }
            // JS eval will discard digits after 24(?) but will not treat them as a
            // syntax error, and JSON allows arbitrary length fractions.
            pos = fractionEnd
        }

        // Optional exponent.
        if (pos < end && 'e' == jsonish.charAt(pos).toAsciiLowerCase()) {
            pos++
            if (pos < end) {
                match(jsonish.charAt(pos)) {
                    // JSON allows explicit + in exponent but not for number as a whole.
                    case '+' | '-' => pos++
                    case _ => ()
                }
            }
            // JSON allows leading zeros on exponent part.
            let expEnd = endOfDigitRun(pos, end)
            if (expEnd == pos) {
                insert(pos, '0')
            }
            pos = expEnd
        }
        if (pos != end) {
            elide(pos, end)
        }
    }
