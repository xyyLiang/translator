    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        try {
            address = BufferTools.byteBufferToString(bytes, Int32(0), Int32(bytes.size - 2))
        } catch (e: Exception) {
            address = ""
        }
        var ratingByte: Int8 = bytes[bytes.size - 1]
        rating = byteToRating.get(ratingByte).getOrDefault({ => -1})
    }