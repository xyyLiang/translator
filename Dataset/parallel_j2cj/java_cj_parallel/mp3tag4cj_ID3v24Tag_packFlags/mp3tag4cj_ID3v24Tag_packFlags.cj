    protected func packFlags(bytesDes: Array<Int8>, offset: Int32): Unit {
        bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(UNSYNCHRONISATION_BIT),
            unsynchronisation
        )
        bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(EXTENDED_HEADER_BIT),
            extendedHeader
        )
        bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(EXPERIMENTAL_BIT),
            experimental
        )
        bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(FOOTER_BIT),
            footer
        )
    }