    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        try {
            language = Option<String>.Some(BufferTools.byteBufferToString(bytes, 1, 3))
        } catch (e: Exception) {
            language = Option<String>.Some("")
        }
        var marker: Int32 = BufferTools.indexOfTerminatorForEncoding(bytes, 4, Int32(bytes[0]))
        if (marker >= Int32(4)) {
            description = Option<EncodedText>.Some(
                EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 4, Int64(marker) - 4)))
            marker += Int32(description.getOrThrow().getTerminator().size)
        } else {
            description = Option<EncodedText>.Some(EncodedText(bytes[0], ""))
            marker = 4
        }
        comment = Option<EncodedText>.Some(
            EncodedText(bytes[0], BufferTools.copyBuffer(bytes, Int64(marker), bytes.size - Int64(marker))))
    }