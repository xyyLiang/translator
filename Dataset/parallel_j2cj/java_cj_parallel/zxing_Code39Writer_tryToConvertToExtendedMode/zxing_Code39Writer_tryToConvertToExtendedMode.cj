    static func tryToConvertToExtendedMode(contents: String): String {
        let extendedContent = StringBuilder()
        for (i in 0..contents.size) {
            let character = contents.charAt(i)
            match (character) {
                case '\u{0000}' => extendedContent.append("%U")
                case ' ' | '-' | '.' => extendedContent.append(character)
                case '@' => extendedContent.append("%V")
                case '`' => extendedContent.append("%W")
                case _ =>
                    if (UInt32(character) <= 26) {
                        extendedContent.append('$')
                        extendedContent.append(Char(UInt32('A') + (UInt32(character) - 1)))
                    } else if (character < ' ') {
                        extendedContent.append('%')
                        extendedContent.append(Char(UInt32('A') + (UInt32(character) - 27)))
                    } else if (character <= ',' || character == '/' || character == ':') {
                        extendedContent.append('/')
                        extendedContent.append(Char(UInt32('A') + (UInt32(character) - 33)))
                    } else if (character <= '9') {
                        extendedContent.append(Char(UInt32('0') + (UInt32(character) - 48)))
                    } else if (character <= '?') {
                        extendedContent.append('%')
                        extendedContent.append(Char(UInt32('F') + (UInt32(character) - 59)))
                    } else if (character <= 'Z') {
                        extendedContent.append(Char(UInt32('A') + (UInt32(character) - 65)))
                    } else if (character <= '_') {
                        extendedContent.append('%')
                        extendedContent.append(Char(UInt32('K') + (UInt32(character) - 91)))
                    } else if (character <= 'z') {
                        extendedContent.append('+')
                        extendedContent.append(Char(UInt32('A') + (UInt32(character) - 97)))
                    } else if (UInt32(character) <= 127) {
                        extendedContent.append('%')
                        extendedContent.append(Char(UInt32('P') + (UInt32(character) - 123)))
                    } else {
                        throw IllegalArgumentException(
                            "Requested content contains a non-encodable character: '${contents.charAt(i)}'")
                    }
                    break
            }
        }

        return extendedContent.toString()
    }