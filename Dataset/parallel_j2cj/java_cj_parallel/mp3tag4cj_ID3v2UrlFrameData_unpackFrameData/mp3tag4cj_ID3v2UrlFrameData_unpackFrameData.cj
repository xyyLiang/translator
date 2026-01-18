    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        var marker: Int32 = BufferTools.indexOfTerminatorForEncoding(bytes, 1, Int32(bytes[0]))
        if (marker >= 0) {
            description = EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 1, Int64(marker - 1)))
            marker += Int32(description.getOrThrow().getTerminator().size)
        } else {
            description = EncodedText(bytes[0], "")
            marker = 1
        }
        try {
            url = Option<String>.Some(BufferTools.byteBufferToString(bytes, marker, Int32(bytes.size - Int64(marker))))
        } catch (e: Exception) {
            url = Option<String>.Some("")
        }
    }