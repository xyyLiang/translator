    protected func unpackFlags (buffer: Array<Int8>): Unit {
        unsynchronisation = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(UNSYNCHRONISATION_BIT))
        extendedHeader = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(EXTENDED_HEADER_BIT))
        experimental = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(EXPERIMENTAL_BIT))
        footer = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(FOOTER_BIT))
    }