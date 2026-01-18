    public func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {_ => 0})
        if (text != Option<EncodedText>.None) {
            bytes[0] = text.getOrThrow().getTextEncoding()
            var textBytes: Array<Int8> = text.getOrThrow().toBytes(true, false)
            if (textBytes.size > 0) {
                BufferTools.copyIntoByteBuffer(textBytes, 0, textBytes.size, bytes, 1)
            }
        }
        return bytes
    }