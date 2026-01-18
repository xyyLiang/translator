    private func sanitizeString(start: Int64, end: Int64): Unit {
        var closed = false
        var i = start
        while (i < end) {            
            let ch = jsonish.charAt(i)
            match(ch) {
                case '\t' => replace(i, i + 1, "\\t")
                // Fixup newlines.
                case '\n' => replace(i, i + 1, "\\n")
                case '\r' => replace(i, i + 1, "\\r")
                // Not newlines in JSON but unparseable by JS eval.
                case '\u{2028}' => replace(i, i + 1, "\\u2028")
                case '\u{2029}' => replace(i, i + 1, "\\u2029")
                // String delimiting quotes that need to be converted : 'foo' -> "foo"
                // or internal quotes that might need to be escaped : f"o -> f\"o.
                case '"' | '\'' => 
                    if (i == start) {
                        if (ch == '\'') {
                            replace(i, i + 1, '"')
                        }
                    } else {
                        if (i + 1 == end) {
                            let startDelim = match(jsonish.charAt(start)) {
                                case '\'' =>  '\''
                                // If we're sanitizing a string whose start was inferred, then
                                // treat '"' as closing regardless.
                                case _ => '"'
                            }
                            closed = startDelim == ch
                        }
                        if (closed) {
                            if (ch == '\'') {
                                replace(i, i + 1, '"')
                            }
                        } else if (ch == '"') {
                            insert(i, '\\')
                        }
                    }
                // Embedding. Disallow <script, </script, <!--, --> and ]]> in string
                // literals so that the output can be embedded in HTML script elements
                // and in XML CDATA sections without affecting the parser state.
                // References:
                // https://www.w3.org/TR/html53/semantics-scripting.html#restrictions-for-contents-of-script-elements
                // https://www.w3.org/TR/html53/syntax.html#script-data-escaped-state
                // https://www.w3.org/TR/html53/syntax.html#script-data-double-escaped-state
                // https://www.w3.org/TR/xml/#sec-cdata-sect
                case '<' =>
                    // Disallow <!--, which lets the HTML parser switch into the "script
                    // data escaped" state.
                    // Disallow <script, which followed by various characters lets the
                    // HTML parser switch into or out of the "script data double escaped"
                    // state.
                    // Disallow </script, which ends a script block.
                    if (i + 3 < end) {
                        var la = i + 1
                        let (d1, c1) = unescapedChar(jsonish, la)
                        la += d1
                        let (d2, c2) = unescapedChar(jsonish, la)
                        la += d2
                        let (_, c3) = unescapedChar(jsonish, la)
                        let lc1 = c1.toAsciiLowerCase()
                        let lc2 = c2.toAsciiLowerCase()
                        let lc3 = c3.toAsciiLowerCase()
                        if ((c1 == '!' && c2 == '-' && c3 == '-') ||
                            (lc1 == 's' && lc2 == 'c' && lc3 == 'r') ||
                            (c1 == '/' && lc2 == 's' && lc3 == 'c')
                        ) {
                            replace(i, i + 1, "\\u003c") // Escaped <
                        }
                    }
                case '>' => 
                    // Disallow -->, which lets the HTML parser switch out of the "script
                    // data escaped" or "script data double escaped" state.
                    if (i - 2 >= start) {
                        var lb = i - 1
                        if ((runSlashPreceding(jsonish, lb) & 1) == 1) {
                            // If the '>' is escaped backup over its slash.
                            lb -= 1
                        }
                        let (d1, cm1) = unescapedCharRev(jsonish, lb)
                        if ('-' == cm1) {
                            lb -= d1
                            let (_, cm2) = unescapedCharRev(jsonish, lb)
                            if ('-' == cm2) {
                                replace(i, i + 1, "\\u003e") // Escaped >
                            }
                        }
                    }
                case ']' => 
                    if (i + 2 < end) {
                        var la = i + 1
                        let (d1, c1) = unescapedChar(jsonish, la)
                        la += d1
                        let (_, c2) = unescapedChar(jsonish, la)
                        if (']' == c1 && '>' == c2) {
                            replace(i, i + 1, "\\u005d")
                        }
                    }
                // Normalize escape sequences.
                case '\\' where i + 1 == end => 
                    elide(i, i + 1)
                case '\\' => 
                    let sch = jsonish.charAt(i + 1)
                    match(sch) {
                        case 'b' | 'f' | 'n' | 'r' | 't' | '\\' | '/' | '"' => i++
                        case 'v' => 
                            // Recognized by JS but not by JSON.
                            replace(i, i + 2, "\\u000B")
                            i++
                        case 'x' where (i + 4 < end && isHexAt(i+2) && isHexAt(i+3)) =>
                            replace(i, i + 2, "\\u00") // \xab -> \u00ab
                            i += 3
                        case 'x' => elide(i, i + 1)
                        case 'u' where i + 6 < end && isHexAt(i + 2) && isHexAt(i + 3) && isHexAt(i + 4) && isHexAt(i + 5) => i += 5
                        case 'u' => elide(i, i + 1)
                        case '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' => 
                            let octalStart = i + 1
                            var octalEnd = octalStart
                            octalEnd++
                            if (octalEnd < end && isOctAt(octalEnd)) {
                                octalEnd++
                                if (UInt32(sch) <= UInt32('3') && octalEnd < end && isOctAt(octalEnd)) {
                                    octalEnd++
                                }
                            }
                            var value = 0u32
                            for (j in octalStart..octalEnd) {
                                let digit = UInt32(jsonish.charAt(j))
                                value = (value << 3) | (digit - ORD_0)
                            }
                            replace(octalStart, octalEnd, "u00")
                            appendHex(value, 2)
                            i = octalEnd - 1
                        case _ => 
                            // Literal char that is recognized by JS but not by JSON.
                            // "\-" is valid JS but not valid JSON.
                            elide(i, i + 1)
                    }
                case _ => 
                    // Escape all control code-points and isolated surrogates which are
                    // not embeddable in XML.
                    // http://www.w3.org/TR/xml/#charsets says
                    //     Char ::= #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD]
                    //            | [#x10000-#x10FFFF]
                    let code = UInt32(ch)
                    let hexEscape = if (code < 0x20) {
                        // Proceed to hex-escape below since control characters are
                        // disallowed by ECMA-404 which governs JavaScript's `JSON.parse`.
                        // Common ones like CR, LF, and TAB are given short escape sequences above.
                        true
                    } else if (code < 0xd800) { // Not a surrogate.
                        false
                    } else if (code < 0xe000) { // A surrogate
                        true
                    } else if (code <= 0xfffd) { // Not one of the 0xff.. controls.
                        false
                    } else {
                        true
                    }
                    if (hexEscape) {
                        replace(i, i + 1, "\\u")
                        let sanitizedJson = this.sanitizedJson.getOrThrow()
                        for (j in 3..=0:-1) {
                            let hex = Int64((code >> (j << 2)) & 0xf)
                            sanitizedJson.append(HEX_DIGITS[hex])
                        }
                    }
            }

            i++
        }
        if (!closed) {
            insert(end, '"')
        }
    }