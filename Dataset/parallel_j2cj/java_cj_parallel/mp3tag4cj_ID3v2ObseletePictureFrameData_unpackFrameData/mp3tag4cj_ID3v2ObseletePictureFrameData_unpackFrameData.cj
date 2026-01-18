    protected override func unpackFrameData(bytes: Array<Int8>): Unit {
        var filetype: String
        try {
            filetype = BufferTools.byteBufferToString(bytes, 1, 3)
        } catch (e: Exception) {
            filetype = "unknown"
        }
        mimeType = Option<String>.Some("image/${filetype.toAsciiLower()}")
        pictureType = bytes[4]
        var marker: Int32 = BufferTools.indexOfTerminatorForEncoding(bytes, 5, Int32(bytes[0]))
        if (marker >= 0) {
            description = Option<EncodedText>.Some(
                EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 5, Int64(marker) - 5)))
            marker += Int32(description.getOrThrow().getTerminator().size)
        } else {
            description = Option<EncodedText>.Some(EncodedText(bytes[0], ""))
            marker = 1
        }
        imageData = BufferTools.copyBuffer(bytes, Int64(marker), bytes.size - Int64(marker))
    }