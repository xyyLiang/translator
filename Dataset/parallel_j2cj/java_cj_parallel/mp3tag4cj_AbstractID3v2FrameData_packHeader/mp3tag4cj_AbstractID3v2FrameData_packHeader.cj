    @OverflowWrapping
    private func packHeader(bytes: Array<Int8>, offset: Int32): Int32 {
        try {
            BufferTools.stringIntoByteBuffer(TAG, 0, TAG.size, bytes, Int64(offset))
        } catch (e: Exception) {}
        var s: Array<String> = version.split(".")
        getMajorMinor(s, offset, bytes)
        packFlags(bytes, offset)
        BufferTools.packSynchsafeInteger(getDataLength(), bytes, offset + DATA_LENGTH_OFFSET)
        return offset + HEADER_LENGTH
    }