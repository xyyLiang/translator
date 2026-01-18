    private func unpackExtendedHeader(bytes: Array<Int8>, offset: Int32): Int32 {
        extendedHeaderLength = BufferTools.unpackSynchsafeInteger(
            bytes[Int64(offset)],
            bytes[Int64(offset) + 1],
            bytes[Int64(offset) + 2],
            bytes[Int64(offset) + 3]
        ) + 4
        extendedHeaderData =
            BufferTools.copyBuffer(
                bytes,
                Int64(offset) + 4,
                Int64(extendedHeaderLength)
            )

        return extendedHeaderLength
    }