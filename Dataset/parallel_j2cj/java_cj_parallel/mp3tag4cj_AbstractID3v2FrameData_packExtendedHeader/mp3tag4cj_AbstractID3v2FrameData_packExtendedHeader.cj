    private func packExtendedHeader(bytes: Array<Int8>, offset: Int32): Int32 {
        BufferTools.packSynchsafeInteger(extendedHeaderLength, bytes, offset)
        BufferTools.copyIntoByteBuffer(extendedHeaderData, 0, extendedHeaderData.size, bytes, Int64(offset) + 4)
        return offset + 4 + Int32(extendedHeaderData.size)
    }