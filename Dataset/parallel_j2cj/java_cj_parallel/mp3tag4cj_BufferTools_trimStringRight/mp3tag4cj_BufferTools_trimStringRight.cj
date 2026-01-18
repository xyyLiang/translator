    @OverflowWrapping
    public static func trimStringRight(s: String): String {
        var endPosition: Int64 = (s.toRuneArray().size - 1) // 3
        var endChar: Char
        while (endPosition >= 0) {
            endChar = s.toRuneArray()[endPosition]
            if (UInt32(endChar) > 32) {
                break
            }
            endPosition--
        }
        if (endPosition == s.toRuneArray().size - 1) {
            return s
        } else if (endPosition < 0) {
            return ""
        }
        return s[..endPosition + 1]
    }