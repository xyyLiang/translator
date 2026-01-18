    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        text = EncodedText(
            bytes[0],
            BufferTools.copyBuffer(bytes, 1, bytes.size - 1)
        )
    }