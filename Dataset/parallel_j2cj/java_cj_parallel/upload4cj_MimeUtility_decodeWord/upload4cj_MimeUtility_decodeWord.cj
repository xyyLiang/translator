    private static func decodeWord(word: String): String {
        if (!word.startsWith(ENCODED_TOKEN_MARKER)) {
            throw ParseException("Invalid RFC 2047 encoded-word: " + word)
        }

        if (word.indexOf("?", 2) == Option<Int64>.None) {
            throw ParseException("Missing charset in RFC 2047 encoded-word: " + word)
        }
        var charsetPos: Int64 = word.indexOf("?", 2).getOrThrow()

        word.substring(2, charsetPos - 2).toAsciiLower() // diff java, cj -> substring(beginIndex, length)

        if (word.indexOf("?", charsetPos + 1) == Option<Int64>.None) {
            throw ParseException("Missing encoding in RFC 2047 encoded-word: " + word);
        }

        var encodingPos: Int64 = word.indexOf("?", charsetPos + 1).getOrThrow()

        let encoding: String = word.substring(charsetPos + 1, encodingPos - charsetPos - 1)

        if (word.indexOf(ENCODED_TOKEN_FINISHER, encodingPos + 1) == Option<Int64>.None) {
            throw ParseException("Missing encoded text in RFC 2047 encoded-word: " + word)
        }
        var encodedTextPos: Int64 = word.indexOf(ENCODED_TOKEN_FINISHER, encodingPos + 1).getOrThrow()

        let encodedText: String = word.substring(encodingPos + 1, encodedTextPos - encodingPos - 1)
        if (encodedText.size == 0) {
            return ""
        }

        try {
            var str: String = ""
            if (encoding.equals(BASE64_ENCODING_MARKER)) {
                var encodedData: Array<UInt8> = fromBase64String(encodedText).getOrThrow()
                 unsafe{
                    str = String.fromUtf8Unchecked(encodedData)
                 }
            } else if (encoding.equals(QUOTEDPRINTABLE_ENCODING_MARKER)) {
                let encodedData: Array<UInt8> = encodedText.toUtf8Array()
                str = QuotedPrintableDecoder.decode(encodedData)
            } else {
                throw UnsupportedEncodingException("Unknown RFC 2047 encoding: " + encoding)
            }
            return str
        } catch (e: Exception) {
            throw UnsupportedEncodingException("Invalid RFC 2047 encoding")
        }
    }