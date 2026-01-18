    public open func packFrame(bytes: Array<Int8>, offset: Int32): Unit {
        packHeader(bytes, offset)
        BufferTools.copyIntoByteBuffer(data, 0, data.size, bytes, Int64(offset) + Int64(HEADER_LENGTH))
    }