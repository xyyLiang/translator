  private static boolean canonicalizeNumber(
      StringBuilder sanitizedJson, int sanStart, int sanEnd) {
    // Now we perform several steps.
    // 1. Convert from scientific notation to regular or vice-versa based on
    //    normalized exponent.
    // 2. Remove trailing zeroes from the fraction and truncate it to 24 digits.
    // 3. Elide the fraction entirely if it is ".0".
    // 4. Convert any 'E' that separates the exponent to lower-case.
    // 5. Elide any minus sign on a zero value.
    // to convert the number to its canonical JS string form.

    // Figure out where the parts of the number start and end.
    int intStart, intEnd, fractionStart, fractionEnd, expStart, expEnd;
    intStart = sanStart + (sanitizedJson.charAt(sanStart) == '-' ? 1 : 0);
    for (intEnd = intStart; intEnd < sanEnd; ++intEnd) {
      char ch = sanitizedJson.charAt(intEnd);
      if (!('0' <= ch && ch <= '9')) { break; }
    }
    if (intEnd == sanEnd || '.' != sanitizedJson.charAt(intEnd)) {
      fractionStart = fractionEnd = intEnd;
    } else {
      fractionStart = intEnd + 1;
      for (fractionEnd = fractionStart; fractionEnd < sanEnd; ++fractionEnd) {
        char ch = sanitizedJson.charAt(fractionEnd);
        if (!('0' <= ch && ch <= '9')) { break; }
      }
    }
    if (fractionEnd == sanEnd) {
      expStart = expEnd = sanEnd;
    } else {
      assert 'e' == (sanitizedJson.charAt(fractionEnd) | 32);
      expStart = fractionEnd + 1;
      if (sanitizedJson.charAt(expStart) == '+') { ++expStart; }
      expEnd = sanEnd;
    }

    assert
         intStart      <= intEnd
      && intEnd        <= fractionStart
      && fractionStart <= fractionEnd
      && fractionEnd   <= expStart
      && expStart      <= expEnd;

    int exp;
    if (expEnd == expStart) {
      exp = 0;
    } else {
      try {
        exp = Integer.parseInt(sanitizedJson.substring(expStart, expEnd), 10);
      } catch (@SuppressWarnings("unused") NumberFormatException ex) {
        // The exponent is out of the range of representable ints.
        // JSON does not place limits on the range of representable numbers but
        // nor does it allow bare numbers as keys.
        return false;
      }
    }

    // Numbered Comments below come from the EcmaScript 5 language specification
    // section 9.8.1 : ToString Applied to the Number Type
    // http://es5.github.com/#x9.8.1

    // 5. let n, k, and s be integers such that k >= 1, 10k-1 <= s < 10k, the
    // Number value for s * 10n-k is m, and k is as small as possible.
    // Note that k is the number of digits in the decimal representation of s,
    // that s is not divisible by 10, and that the least significant digit of s
    // is not necessarily uniquely determined by these criteria.
    int n = exp;  // Exponent

    // s, the string of decimal digits in the representation of m are stored in
    // sanitizedJson.substring(intStart).
    // k, the number of digits in s is computed later.

    // Leave only the number representation on the output buffer after intStart.
    // This leaves any sign on the digit per
    // 3. If m is less than zero, return the String concatenation of the
    //    String "-" and ToString(-m).
    boolean sawDecimal = false;
    boolean zero = true;
    int digitOutPos = intStart;
    for (int i = intStart, nZeroesPending = 0; i < fractionEnd; ++i) {
      char ch = sanitizedJson.charAt(i);
      if (ch == '.') {
        sawDecimal = true;
        if (zero) { nZeroesPending = 0; }
        continue;
      }

      char digit = ch;
      if ((!zero || digit != '0') && !sawDecimal) { ++n; }

      if (digit == '0') {
        // Keep track of runs of zeros so that we can take them into account
        // if we later see a non-zero digit.
        ++nZeroesPending;
      } else {
        if (zero) {  // First non-zero digit.
          // Discard runs of zeroes at the front of the integer part, but
          // any after the decimal point factor into the exponent, n.
          if (sawDecimal) {
            n -= nZeroesPending;
          }
          nZeroesPending = 0;
        }
        zero = false;
        while (nZeroesPending != 0 || digit != 0) {
          char vdigit;
          if (nZeroesPending == 0) {
            vdigit = digit;
            digit = (char) 0;
          } else {
            vdigit = '0';
            --nZeroesPending;
          }

          // TODO: limit s to 21 digits?
          sanitizedJson.setCharAt(digitOutPos++, vdigit);
        }
      }
    }
    sanitizedJson.setLength(digitOutPos);
    // Number of digits in decimal representation of s.
    int k = digitOutPos - intStart;

    // Now we have computed n, k, and s as defined above.  Time to add decimal
    // points, exponents, and leading zeroes per the rest of the JS number
    // formatting specification.

    if (zero) {  // There are no non-zero decimal digits.
      // 2. If m is +0 or -0, return the String "0".
      sanitizedJson.setLength(sanStart);  // Elide any sign.
      sanitizedJson.append('0');
      return true;
    }

    // 6. If k <= n <= 21, return the String consisting of the k digits of the
    // decimal representation of s (in order, with no leading zeroes),
    // followed by n-k occurrences of the character '0'.
    if (k <= n && n <= 21) {
      for (int i = k; i < n; ++i) {
        sanitizedJson.append('0');
      }

    // 7. If 0 < n <= 21, return the String consisting of the most significant n
    // digits of the decimal representation of s, followed by a decimal point
    // '.', followed by the remaining k-n digits of the decimal representation
    // of s.
    } else if (0 < n && n <= 21) {
      sanitizedJson.insert(intStart + n, '.');

    // 8. If -6 < n <= 0, return the String consisting of the character '0',
    // followed by a decimal point '.', followed by -n occurrences of the
    // character '0', followed by the k digits of the decimal representation of
    // s.
    } else if (-6 < n && n <= 0) {
      sanitizedJson.insert(intStart, "0.000000".substring(0, 2 - n));

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
        sanitizedJson.insert(intStart + 1, '.');
      }
      int nLess1 = n-1;
      sanitizedJson.append('e').append(nLess1 < 0 ? '-' : '+')
          .append(Math.abs(nLess1));
    }
    return true;
  }
