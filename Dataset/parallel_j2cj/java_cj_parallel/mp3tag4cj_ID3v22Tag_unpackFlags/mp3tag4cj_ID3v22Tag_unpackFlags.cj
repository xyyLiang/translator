    protected override func unpackFlags(bytes: Array<Int8>): Unit {
        unsynchronisation = BufferTools.checkBit(bytes[Int64(FLAGS_OFFSET)], Int64(UNSYNCHRONISATION_BIT))
        compression = BufferTools.checkBit(bytes[Int64(FLAGS_OFFSET)], Int64(COMPRESSION_BIT))
    }