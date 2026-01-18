    protected static func bytesToCharBuffer(bytes: Array<Int8>, characterSet: String): String {
        var charSet: Charset = match (Charsets.forName(characterSet)) {
            case Some(x) => x
            case None => throw BaseException("Character set not found")
        }
        return charSet.newDecoder().decode(BufferTools.transInt8ArrayToUInt8(bytes))
    }