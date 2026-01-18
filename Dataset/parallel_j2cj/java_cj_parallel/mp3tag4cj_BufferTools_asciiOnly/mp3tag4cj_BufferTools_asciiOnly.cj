    @OverflowWrapping
    public static func asciiOnly(s: String): String {
        var newString: StringBuilder = StringBuilder()
        let charArray = s.toRuneArray()
        for (i in 0..charArray.size) {
            var ch: Char = charArray[i]
            if (UInt32(ch) < 32 || UInt32(ch) > 126) {
                newString.append('?')
            } else {
                newString.append(ch)
            }
        }
        return newString.toString()
    }