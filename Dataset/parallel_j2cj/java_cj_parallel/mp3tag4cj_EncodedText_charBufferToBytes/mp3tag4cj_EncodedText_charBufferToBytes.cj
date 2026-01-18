    protected static func charBufferToBytes(charBuffer: String, characterSet: String): Array<Int8> {
        var charSet: Charset = match (Charsets.forName(characterSet)) {
            case Some(x) => x
            case None => throw BaseException("Character set not found")
        }
        var byteBuffer: Array<UInt8> = charSet.newEncoder().encode(charBuffer)
        if (checkByteBuffer(byteBuffer)) {
            throw BaseException("Character set not found")
        }
        return BufferTools.transUInt8ArrayToInt8(BufferTools.copyBuffer(byteBuffer, 0, byteBuffer.size))
    }