    protected open func unpackFrameData(bytes: Array<Int8>): Unit {
        var marker: Int32 = BufferTools.indexOfTerminator(bytes, 1, 1);
        if (marker >= 0) {
            try {
                mimeType = Option<String>.Some(BufferTools.byteBufferToString(bytes, 1, marker - 1))
            } catch (e: Exception) {
                mimeType = Option<String>.Some("image/unknown")
            }
        } else {
            mimeType = Option<String>.Some("image/unknown")
        }
        pictureType = bytes[Int64(marker) + 1]
        marker += 2
        var marker2: Int32 = BufferTools.indexOfTerminatorForEncoding(bytes, marker, Int32(bytes[0]))
        if (marker2 >= 0) {
            description = Option<EncodedText>.Some(
                EncodedText(bytes[0], BufferTools.copyBuffer(bytes, Int64(marker), Int64(marker2 - marker))))
            marker2 += Int32(description.getOrThrow().getTerminator().size)
        } else {
            description = Option<EncodedText>.Some(EncodedText(bytes[0], ""))
            marker2 = marker
        }
        imageData = Option<Array<Int8>>.Some(BufferTools.copyBuffer(bytes, Int64(marker2), bytes.size - Int64(marker2)))
    }