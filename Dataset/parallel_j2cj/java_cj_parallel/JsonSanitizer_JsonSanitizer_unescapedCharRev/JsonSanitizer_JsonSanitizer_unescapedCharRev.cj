    private static func unescapedCharRev(s: CharArray, rightIncl: Int64): (Int64, Char) {
        if (rightIncl < 0) {
            return (0, Char(0))
        }
        // \?
        // \01
        // \012
        // \x00
        // \u0000
        for (i in 1..6) {
            let left = rightIncl - i
            if (left < 0) {
                break
            }
            if (s.charAt(left) == '\\') {
                // If there are an odd number of '\\' then decode.
                var n = 1
                while (left - n >= 0 && s.charAt(left - n) == '\\') {
                    n++
                }
                if ((n & 1) == 1) {
                    let unescaped = unescapedChar(s, left)
                    if (unescaped[0] - 1 == i) {
                        return unescaped
                    }
                }
                break
            }
        }
        return (1, s.charAt(rightIncl))
    }