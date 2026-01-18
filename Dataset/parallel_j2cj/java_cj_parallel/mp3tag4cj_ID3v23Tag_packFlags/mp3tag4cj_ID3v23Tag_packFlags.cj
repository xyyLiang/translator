    protected func packFlags(bytes: Array<Int8>, offset: Int32): Unit {
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(UNSYNCHRONISATION_BIT),
            unsynchronisation
        )
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(EXTENDED_HEADER_BIT),
            extendedHeader
        )
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(EXPERIMENTAL_BIT),
            experimental
        )
    }