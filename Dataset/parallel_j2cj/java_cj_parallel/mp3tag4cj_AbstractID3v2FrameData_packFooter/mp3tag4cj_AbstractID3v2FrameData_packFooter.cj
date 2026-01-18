    @OverflowWrapping
    private func packFooter(bytes: Array<Int8>, offset: Int32): Int32 {
        try {
            BufferTools.stringIntoByteBuffer(FOOTER_TAG, 0, FOOTER_TAG.size, bytes, Int64(offset))
        } catch (e: Exception) {}
        var s: Array<String> = version.split(".")
        getMajorMinor(s, offset, bytes)
        packFlags(bytes, offset)
        BufferTools.packSynchsafeInteger(getDataLength(), bytes, offset + DATA_LENGTH_OFFSET)
        return offset + FOOTER_LENGTH
    }