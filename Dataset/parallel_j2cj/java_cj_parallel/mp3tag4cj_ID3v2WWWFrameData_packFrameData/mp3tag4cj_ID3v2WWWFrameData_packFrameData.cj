    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        try {
            url = BufferTools.byteBufferToString(bytes, 0, Int32(bytes.size))
        } catch (e: Exception) {
            url = Option<String>.Some("")
        }
    }