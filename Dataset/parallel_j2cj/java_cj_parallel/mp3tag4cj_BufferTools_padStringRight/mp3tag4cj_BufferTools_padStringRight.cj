    @OverflowWrapping
    public static func padStringRight(s: String, length: Int64, padWith: Char): String {
        if (s.toRuneArray().size >= length) {
            return s
        }
        var stringBuffer: StringBuilder = StringBuilder(s)
        while (stringBuffer.toString().toRuneArray().size < length) {
            stringBuffer.append(padWith)
        }
        return stringBuffer.toString()
    }