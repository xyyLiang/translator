    protected func unpackDataLength(buffer: Array<Int8>, offset: Int32): Unit {
        dataLength = BufferTools.unpackSynchsafeInteger(
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET)],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 1],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 2],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 3]
        )
    }