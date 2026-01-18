    protected override func unpackDataLength(buffer: Array<Int8>, offset: Int32): Unit {
        dataLength = BufferTools.unpackInteger(
            Int8(0),
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET_ZI)],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET_ZI) + 1],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET_ZI) + 2]
        )
    }