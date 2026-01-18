    public static func decodeText(text: String): Option<String> {
        if (text.indexOf(ENCODED_TOKEN_MARKER) == Option<Int64>.None) {return text}
        var offset: Int64 = 0
        var endOffset: Int64 = text.size
        var startWhiteSpace: Int64 = -1
        var endWhiteSpace: Int64 = -1
        var decodedText: StringBuilder = StringBuilder()
        var previousTokenEncoded: Bool = false
        while (offset < endOffset) {
            var ch = text.toRuneArray().get(offset).getOrThrow()
            if (LINEAR_WHITESPACE.indexOf(ch) != Option<Int64>.None) {
                startWhiteSpace = offset
                while (offset < endOffset) {
                    ch = text.toRuneArray().get(offset).getOrThrow()
                    if (LINEAR_WHITESPACE.indexOf(ch) != Option<Int64>.None) { // whitespace found
                        offset++
                    } else {
                        endWhiteSpace = offset
                        break
                    }
                }
            } else {
                var wordStart: Int64 = offset
                while (offset < endOffset) {
                    ch = text.toRuneArray().get(offset).getOrThrow()
                    if (LINEAR_WHITESPACE.indexOf(ch) == Option<Int64>.None) {offset++} else {break}
                }
                let word: String = text.substring(wordStart, offset - wordStart)
                if (word.startsWith(ENCODED_TOKEN_MARKER)) {
                    try {
                        let decodedWord: String = decodeWord(word)
                        if (!previousTokenEncoded && startWhiteSpace != -1) {
                            decodedText.append(text.substring(startWhiteSpace, endWhiteSpace - startWhiteSpace))
                            startWhiteSpace = -1
                        }
                        previousTokenEncoded = true
                        decodedText.append(decodedWord)
                        continue
                    } catch (e: ParseException) {}
                }
                if (startWhiteSpace != -1) {
                    decodedText.append(text.substring(startWhiteSpace, endWhiteSpace - startWhiteSpace))
                    startWhiteSpace = -1
                }
                previousTokenEncoded = false
                decodedText.append(word)
            }
        }
        return decodedText.toString()
    }