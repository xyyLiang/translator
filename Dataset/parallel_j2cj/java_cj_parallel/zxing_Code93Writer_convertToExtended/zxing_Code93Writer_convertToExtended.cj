    static func convertToExtended(contents: String): String {
        let length = contents.size
        let extendedContent = StringBuilder()
        for (i in 0..length) {
            let character = contents.charAt(i)
            if (UInt32(character) == 0) {
                extendedContent.append("bU")
            } else if (UInt32(character) <= 26) {
                extendedContent.append('a')
                extendedContent.append(Char(UInt32('A') + UInt32(character) - 1))
            } else if (UInt32(character) <= 31) {
                extendedContent.append('b')
                extendedContent.append(Char(UInt32('A') + UInt32(character) - 27))
            } else if (character == ' ' || character == '$' || character == '%' || character == '+') {
                extendedContent.append(character)
            } else if (character <= ',') {
                extendedContent.append('c')
                extendedContent.append(Char(UInt32('A') + UInt32(character) - UInt32('!')))
            } else if (character <= '9') {
                extendedContent.append(character)
            } else if (character == ':') {
                extendedContent.append("cZ")
            } else if (character <= '?') {
                extendedContent.append('b')
                extendedContent.append(Char(UInt32('F') + UInt32(character) - UInt32(';')))
            } else if (character == '@') {
                extendedContent.append("bV")
            } else if (character <= 'Z') {
                extendedContent.append(character)
            } else if (character <= '_') {
                extendedContent.append('b')
                extendedContent.append(Char(UInt32('K') + UInt32(character) - UInt32('[')))
            } else if (character == '`') {
                extendedContent.append("bW")
            } else if (character <= 'z') {
                extendedContent.append('d')
                extendedContent.append(Char(UInt32('A') + UInt32(character) - UInt32('a')))
            } else if (UInt32(character) <= 127) {
                extendedContent.append('b')
                extendedContent.append(Char(UInt32('P') + UInt32(character) - UInt32('{')))
            } else {
                throw IllegalArgumentException("Requested content contains a non-encodable character: '${character}'")
            }
        }
        extendedContent.toString()
    }