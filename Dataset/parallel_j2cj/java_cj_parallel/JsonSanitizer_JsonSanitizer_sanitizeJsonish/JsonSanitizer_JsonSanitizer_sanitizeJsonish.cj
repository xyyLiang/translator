    func sanitizeJsonish(): Unit {
        // Return to consistent state.
        bracketDepth = 0
        cleaned = 0
        sanitizedJson = None
        isMap_ = None

        var state = State.START_ARRAY
        let n = jsonish.size()

        // Walk over each token and either validate it, by just advancing i and
        // computing the next state, or manipulate cleaned&sanitizedJson so that
        // sanitizedJson contains the sanitized equivalent of
        // jsonish.substring(0, cleaned).
        var i = 0
        while (i < n) {
            try {
                let ch = jsonish.charAt(i)
                if (SUPER_VERBOSE_AND_SLOW_LOGGING) {
                    let sanitizedJsonStr = (sanitizedJson?.toString() ?? "") + jsonish.substring(cleaned, i - cleaned)
                    println("i=${i}, ch=${ch}\\u${UInt32(ch).format("04x")}, state=${state}, sanitized=${sanitizedJsonStr}")
                }
                match(ch) {
                    case '\t' | '\n' | '\r' | ' ' => ()
                    case '"' | '\'' =>
                        state = requireValueState(i, state, true)
                        let strEnd = endOfQuotedString(jsonish, i)
                        sanitizeString(i, strEnd)
                        i = strEnd - 1
                    case '(' | ')' => 
                        // Often JSON-like content which is meant for use by eval is
                        // wrapped in parentheses so that the JS parser treats contained
                        // curly brackets as part of an object constructor instead of a
                        // block statement.
                        // We elide these grouping parentheses to ensure valid JSON.
                        elide(i, i + 1)
                    case '{' | '[' =>
                        state = requireValueState(i, state, false)
                        let map = ch == '{'
                        isMap[bracketDepth] = map
                        bracketDepth++
                        state = if (map) {
                            State.START_MAP
                        } else {
                            State.START_ARRAY
                        }
                    
                    case '}' | ']' => 
                        if (bracketDepth == 0) {
                            elide(i, jsonish.size())
                            break
                        }

                        // Strip trailing comma to convert {"a":0,} -> {"a":0}
                        // and [1,2,3,] -> [1,2,3,]

                        match(state) {
                            case BEFORE_VALUE => insert(i, "null")
                            case BEFORE_ELEMENT | BEFORE_KEY => elideTrailingComma(i)
                            case AFTER_KEY => insert(i, ":null")
                            case START_MAP | START_ARRAY | AFTER_ELEMENT | AFTER_VALUE => ()
                        }

                        bracketDepth--
                        let closeBracket = if (isMap[bracketDepth]) {
                            '}'
                        } else {
                            ']'
                        }
                        
                        if (ch != closeBracket) {
                            replace(i, i + 1, closeBracket)
                        }
                        state =  if (bracketDepth == 0 || !isMap[bracketDepth - 1]) {
                            State.AFTER_ELEMENT
                        } else {
                            State.AFTER_VALUE
                        }
                    
                    case ',' => 
                        if (bracketDepth == 0) {
                            throw UNBRACKETED_COMMA
                        }
                        // Convert comma elisions like [1,,3] to [1,null,3].
                        // [1,,3] in JS is an array that has no element at index 1
                        // according to the "in" operator so accessing index 1 will
                        // yield the special value "undefined" which is equivalent to
                        // JS's "null" value according to "==".
                        match(state) {
                            // Normal
                            case AFTER_ELEMENT => state = State.BEFORE_ELEMENT
                            case AFTER_VALUE => state = State.BEFORE_KEY
                            // Array elision.
                            case START_ARRAY | BEFORE_ELEMENT => 
                                insert(i, "null")
                                state = State.BEFORE_ELEMENT
                            // Ignore
                            case START_MAP | BEFORE_KEY | AFTER_KEY => elide(i, i + 1)
                            // Supply missing value.
                            case BEFORE_VALUE => 
                                insert(i, "null")
                                state = State.BEFORE_KEY
                        }
                    case ':' =>
                        if (state == State.AFTER_KEY) {
                            state = State.BEFORE_VALUE
                        } else {
                            elide(i, i + 1)
                        }
                    case '/' => 
                        // Skip over JS-style comments since people like inserting them into
                        // data files and getting huffy with Crockford when he says no to
                        // versioning JSON to allow ignorable tokens.
                        var end = i + 1
                        if (i + 1 < n) {
                            match(jsonish.charAt(i + 1)) {
                                case '/' =>
                                    end = n // Worst case.
                                    for (j in i + 2..n) {
                                        let cch = jsonish.charAt(j)
                                        if (cch == '\n' || cch == '\r' || cch == '\u{2028}' || cch == '\u{2029}') {
                                            end = j + 1
                                            break
                                        }
                                    }
                                case '*' => 
                                    end = n
                                    if (i + 3 < n) {
                                        var j = i + 2
                                        while (true) {
                                            j = match(jsonish.indexOf('/', j + 1)) {
                                                case Some(val) => val
                                                case None => break
                                            }
                                            if (jsonish.charAt(j - 1) == '*') {
                                                end = j + 1
                                                break
                                            }
                                        }
                                    }
                                case _ => ()
                            }
                        }
                        elide(i, end)
                        i = end - 1
                    case _ =>
                        // Three kinds of other values can occur.
                        // 1. Numbers
                        // 2. Keyword values ("false", "null", "true")
                        // 3. Unquoted JS property names as in the JS expression
                        //      ({ foo: "bar"})
                        //    which is equivalent to the JSON
                        //      { "foo": "bar" }
                        // 4. Cruft tokens like BOMs.

                        // Look for a run of '.', [0-9], [a-zA-Z_$], [+-] which subsumes
                        // all the above without including any JSON special characters
                        // outside keyword and number.
                        var runEnd = i
                        while (runEnd < n) {
                            let tch = jsonish.charAt(runEnd)
                            if (('a' <= tch && tch <= 'z') || ('0' <= tch && tch <= '9') || tch == '+' || tch == '-' || tch == '.' || ('A' <= tch && tch <= 'Z') || tch == '_' || tch == '$') {
                                runEnd++
                            } else {
                                break
                            }
                        }

                        if (runEnd == i) {
                            elide(i, i + 1)
                        } else {
                            state = requireValueState(i, state, true)
                            let isNumber = ('0' <= ch && ch <= '9') || ch == '.' || ch == '+' || ch == '-'
                            let isKeyword = !isNumber && isKeyword(i, runEnd)
                            if (!(isNumber || isKeyword)) {
                                // We're going to have to quote the output.  Further expand to
                                // include more of an unquoted token in a string.
                                while (runEnd < n) {
                                    if (isJsonSpecialChar(runEnd)) {
                                        break
                                    }
                                    runEnd++
                                }

                                if (runEnd < n && jsonish.charAt(runEnd) == '"') {
                                    runEnd++
                                }
                            }

                            if (state == State.AFTER_KEY) {
                                // We need to quote whatever we have since it is used as a
                                // property name in a map and only quoted strings can be used that
                                // way in JSON.
                                insert(i, '"')
                                if (isNumber) {
                                    // By JS rules,
                                    //   { .5e-1: "bar" }
                                    // is the same as
                                    //   { "0.05": "bar" }
                                    // because a number literal is converted to its string form
                                    // before being used as a property name.
                                    canonicalizeNumber(i, runEnd)
                                    // We intentionally ignore the return value of canonicalize.
                                    // Uncanonicalizable numbers just get put straight through as
                                    // string values.
                                    insert(runEnd, '"')
                                } else {
                                    sanitizeString(i, runEnd)
                                }
                            } else {
                                if (isNumber) {
                                    // Convert hex and octal constants to decimal and ensure that
                                    // integer and fraction portions are not empty.
                                    normalizeNumber(i, runEnd)
                                } else if (!isKeyword) {
                                    // Treat as an unquoted string literal.
                                    insert(i, '"')
                                    sanitizeString(i, runEnd)
                                }
                            }
                            i = runEnd - 1   
                        }
                }
            } catch(e: UnbracketedComma) {
                elide(i, jsonish.size())
                break
            }

            i++
        }

        if (state == State.START_ARRAY && bracketDepth == 0) {
            // No tokens.  Only whitespace
            insert(n, "null")
            state = State.AFTER_ELEMENT
        }

        if (SUPER_VERBOSE_AND_SLOW_LOGGING) {
            let sanitizedJsonStr = sanitizedJson?.toString() ?? ""
            println("state=${state}, sanitizedJson=${sanitizedJsonStr}, cleaned=${cleaned}, bracketDepth=${bracketDepth}")
        }

        let sanitizedJsonSize = sanitizedJson?.size() ?? 0
        if (sanitizedJsonSize != 0 || cleaned != 0 || bracketDepth != 0) {
            let sanitizedJson = match(this.sanitizedJson) {
                case Some(val) => val
                case None => 
                    let val = CharArrayList(n + bracketDepth)
                    this.sanitizedJson = val
                    val
            }

            sanitizedJson.append(jsonish.slice(cleaned, n-cleaned))
            cleaned = n

            match(state) {
                case BEFORE_ELEMENT | BEFORE_KEY => elideTrailingComma(n)
                case AFTER_KEY => sanitizedJson.append(":null")
                case BEFORE_VALUE => sanitizedJson.append("null")
                case _ => ()
            }

            // Insert brackets to close unclosed content.
            while (bracketDepth != 0) {
                bracketDepth--
                sanitizedJson.append(
                    if (isMap[bracketDepth]) {
                        '}'
                    } else {
                        ']'
                    }
                )
            }
        }
    }