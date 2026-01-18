    private func packHeader(bytes: Array<Int8>, _: Int32): Unit {
        try {
            BufferTools.stringIntoByteBuffer(id, 0, id.size, bytes, 0)
        } catch (e: IllegalArgumentException) {}
        BufferTools.copyIntoByteBuffer(packDataLength(), 0, 4, bytes, 4)
        BufferTools.copyIntoByteBuffer(packFlags(), 0, 2, bytes, 8)
    }