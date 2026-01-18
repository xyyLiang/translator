    private static func unescapedChar(s: CharArray, left: Int64): (Int64, Char) {
        let n = s.size()
        if (left >= n) {
            return (0, Char(0))
        }
        let c = s.charAt(left)
        if (c == '\\') {
            if (left + 1 == n) {
                return (1, Char(0))
            }
            let nc = s.charAt(left + 1)
            match(nc) {
                case '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' =>
                    let octalStart = left + 1
                    var octalEnd = octalStart
                    octalEnd++
                    if (octalEnd < n && isOct(s.charAt(octalEnd))) {
                        octalEnd++
                        if (nc <= '3' && octalEnd < n && isOct(s.charAt(octalEnd))) {
                            octalEnd++
                        }
                    }
                    var value = 0u32
                    for (j in octalStart..octalEnd) {
                        let digit = UInt32(s.charAt(j))
                        value = (value << 3) | (digit - ORD_0)
                    }
                    return (octalEnd - left, Char(value))
                case 'x' => 
                    if (left + 3 < n) {
                        let d0 = s.charAt(left + 2)
                        let d1 = s.charAt(left + 3)
                        if (isHex(d0) && isHex(d1)) {
                            return (4, Char((hexVal(d0) << 4) | hexVal(d1)))
                        }
                    }
                case 'u' => 
                    if (left + 5 < n) {
                        let d0 = s.charAt(left + 2)
                        let d1 = s.charAt(left + 3)
                        let d2 = s.charAt(left + 4)
                        let d3 = s.charAt(left + 5)
                        if (isHex(d0) && isHex(d1) && isHex(d2) && isHex(d3)) {
                            let code = (hexVal(d0) << 12) | (hexVal(d1) << 8) | (hexVal(d2) << 4) | hexVal(d3)
                            if (code < 0xd800 || code > 0xdfff) {
                                return (6, Char(code))
                            }
                        }
                    }
                case 'b' => return (2, '\b')
                case 'f' => return (2, '\f')
                case 'n' => return (2, '\n')
                case 'r' => return (2, '\r')
                case 't' => return (2, '\t')
                case 'v' => return (2, '\v')
                case _ => ()
            }
            return (2, nc)
        } else {
            return (1, c)
        }
    }