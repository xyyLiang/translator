    static func encodeText(input: ECIInput, startpos: Int64, count: Int64, sb: StringBuilder, initialSubmode: Int64): Int64 {
        let tmp = StringBuilder()
        var submode = initialSubmode
        var idx = 0
        while (true) {
            if (input.isECI(startpos + idx)) {
                encodingECI(input[startpos + idx], sb)
                idx++
            } else {
                let ch = input.charAt(startpos + idx)
                if (submode == SUBMODE_ALPHA) {
                    if (isAlphaUpper(ch)) {
                        if (ch == ' ') {
                            tmp.append(Char(26))
                        } else {
                            tmp.append(Char(UInt32(ch) - 65))
                        }
                    } else {
                        if (isAlphaLower(ch)) {
                            submode = SUBMODE_LOWER
                            tmp.append(Char(27))
                            continue
                        } else if (isMixed(ch)) {
                            submode = SUBMODE_MIXED
                            tmp.append(Char(28))
                            continue
                        } else {
                            tmp.append(Char(29))
                            tmp.append(Char(PUNCTUATION[Int64(UInt32(ch))]))
                            break
                        }
                    }
                } else if (submode == SUBMODE_LOWER) {
                    if (isAlphaLower(ch)) {
                        if (ch == ' ') {
                            tmp.append(Char(26))
                        } else {
                            tmp.append(Char(UInt32(ch) - 97))
                        }
                    } else {
                        if (isAlphaUpper(ch)) {
                            tmp.append(Char(27))
                            tmp.append(Char(UInt32(ch) - 65))
                            break
                        } else if (isMixed(ch)) {
                            submode = SUBMODE_MIXED
                            tmp.append(Char(28))
                            continue
                        } else {
                            tmp.append(Char(29))
                            tmp.append(Char(PUNCTUATION[Int64(UInt32(ch))]))
                            break
                        }
                    }
                } else if (submode == SUBMODE_MIXED) {
                    if (isMixed(ch)) {
                        tmp.append(Char(MIXED[Int64(UInt32(ch))]))
                    } else {
                        if (isAlphaUpper(ch)) {
                            submode = SUBMODE_ALPHA
                            tmp.append(Char(28))
                            continue
                        } else if (isAlphaLower(ch)) {
                            submode = SUBMODE_LOWER
                            tmp.append(Char(27))
                            continue
                        } else {
                            if (startpos + idx + 1 < count && !input.isECI(startpos + idx + 1) && isPunctuation(
                                input.charAt(startpos + idx + 1))) {
                                submode = SUBMODE_PUNCTUATION
                                tmp.append(Char(25))
                                continue
                            }
                            tmp.append(Char(29))
                            tmp.append(Char(PUNCTUATION[Int64(UInt32(ch))]))
                        }
                    }
                } else {
                    if (isPunctuation(ch)) {
                        tmp.append(Char(PUNCTUATION[Int64(UInt32(ch))]))
                    } else {
                        submode = SUBMODE_ALPHA
                        tmp.append(Char(29))
                        continue
                    }
                }
                idx++
                if (idx >= count) {
                    break
                }
            }
        }
        var h = Char(0)
        let t = tmp.toCharArray()
        for (i in 0..tmp.size) {
            let odd = (i % 2) != 0
            if (odd) {
                h = Char(UInt32(h) * 30 + UInt32(t[i]))
                sb.append(h)
            } else {
                h = t[i]
            }
        }
        if ((tmp.size % 2) != 0) {
            sb.append(Char(UInt32(h) * 30 + 29))
        }
        submode
    }