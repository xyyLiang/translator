    private static func minify_(json: CharArray, force: Bool): String {
        let pool = HashMap<Token, Token>()
        let n = json.size()
        var i = 0
        var potentialSavings = 0
        while (i < n) {
            let ch = json.charAt(i)
            var tokEnd: Int64
            if (ch == '"') {
                tokEnd = i + 1
                while (tokEnd < n) {
                    let tch = json.charAt(tokEnd)
                    if (tch == '\\') {
                        tokEnd++
                    } else if (tch == '"') {
                        tokEnd++
                        break
                    }
                    tokEnd++
                }
            } else if (isLetterOrNumberChar(ch)) {
                tokEnd = i + 1
                while (tokEnd < n && isLetterOrNumberChar(json.charAt(tokEnd))) {
                    tokEnd++
                }
            } else {
                if ((ch == '\t' || ch == '\n' || ch == '\r' || ch == ' ')) {
                    potentialSavings++
                }
                i++
                continue
            }

            var nextNonWhitespace = tokEnd
            while (nextNonWhitespace < n) {
                let wch = json.charAt(nextNonWhitespace)
                if (!(wch == '\t' || wch == '\n' || wch == '\r' || wch == ' ')) {
                    break
                }
                nextNonWhitespace++
                potentialSavings++
            }

            // If the string is followed by a ':' then it is a map key and cannot be
            // substituted with an identifier.
            // In JavaScript, { a: 1 } is the same as { "a": 1 } regardless of
            // what the identifier "a" resolves to.
            if ((nextNonWhitespace == n || ':' != json.charAt(nextNonWhitespace)) && tokEnd - i >= 4) {
                let tok = Token(i, tokEnd, json)
                match(pool.put(tok, tok)) {
                    case Some(last) =>
                        tok.prev = last
                    case None => ()
                }
            }
            i = nextNonWhitespace
        }

        // Now look at all the token groups that have a next, and then count up the
        // savings to see if they meet the cost of the boilerplate.
        let dupes = ArrayList<Token>()
        let values = HashSet(pool.values())
        for (tok in pool.values()) {
            match(tok.prev) {
                case None => 
                    values.remove(tok)
                    continue
                case _ => ()
            }

            var chainDepth = 0
            for (_ in tok) {
                chainDepth++
            }
            let tokSavings = (chainDepth - 1) * (tok.end - tok.start) - MARGINAL_VAR_COST
            if (tokSavings > 0) {
                potentialSavings += tokSavings
                for (t in tok) {
                    dupes.append(t)
                }
            }
        }

        if (!force && potentialSavings <= BOILERPLATE_COST + SAVINGS_THRESHOLD) {
            return json.toString()
        }

        // Dump the tokens into an array and sort them.
        dupes.sortBy { a, b => a.start.compare(b.start) }

        let nTokens = dupes.size()

        let sb = StringBuilder(n)
        sb.append(ENVELOPE_P1)
        {
            let nameGenerator = NameGenerator()
            var first = true
            for (tok in values) {
                let name = nameGenerator.next()
                for (t in tok) {
                    t.name = name
                }
                
                if (first) {
                    first = false
                } else {
                    sb.append(',')
                }
                sb.append(name)
            }
        }()

        sb.append(ENVELOPE_P2)
        let afterReturn = sb.size()
        var pos = 0
        var tokIndex = 0
        while (true) {
            let (tok, limit): (?Token, Int64) = if (tokIndex < nTokens) {
                let t = dupes[tokIndex]
                tokIndex++
                (t, t.start)
            } else {
                (None, n)
            }
            
            var inString = false
            var i = pos
            while (i < limit) {
                let ch = json.charAt(i)
                if (inString) {
                    if (ch == '"') {
                        inString = false
                    } else if (ch == '\\') {
                        i++
                    }
                } else if (ch == '\t' || ch == '\n' || ch == '\r' || ch == ' ') {
                    if (pos != i) {
                        sb.append(json.substring(pos, i-pos))
                    }
                    pos = i + 1
                } else if (ch == '"') {
                    inString = true
                }
                i++
            }
            // There should be no token boundaries inside strings.
            if (inString) {
                throw AssertionError("assert !inString, inString=${inString}")
            }
            if (pos != limit) {
                sb.append(json.substring(pos, limit - pos))
            }
            match(tok) {
                case Some(t) =>
                    sb.append(t.name.getOrThrow())
                    pos = t.end
                case None => break
            }
        }

        {
            // Insert space after return if required.
            // This is unlikely to occur in practice.
            let ch = sb.charAt(afterReturn)
            if (ch != '{' && ch != '[' && ch != '"') {
                sb.insert(afterReturn, ' ')
            }
        }()

        sb.append(ENVELOPE_P3)
        {
            var first = true
            for (tok in values) {
                if (first) {
                    first = false
                } else {
                    sb.append(',')
                }
                sb.append(tok.seq.substring(tok.start, tok.len))
            }
        }()
        sb.append(ENVELOPE_P4)

        return sb.toString()
    }