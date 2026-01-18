    private func unpackHeader(bytes: Array<Int8>): Int32 {
        var majorVersion: Int8 = bytes[Int64(MAJOR_VERSION_OFFSET)]
        var minorVersion: Int8 = bytes[Int64(MINOR_VERSION_OFFSET)]
        version = majorVersion.toString() + "." + minorVersion.toString()
        if (majorVersion != 2 && majorVersion != 3 && majorVersion != 4) {
            throw UnsupportedTagException("Unsupported version ${version}")
        }
        unpackFlags(bytes)
        if ((bytes[Int64(FLAGS_OFFSET)] & 15) != 0) {
            throw UnsupportedTagException("Unrecognised bits in header")
        }
        dataLength = BufferTools.unpackSynchsafeInteger(
            bytes[Int64(DATA_LENGTH_OFFSET)],
            bytes[Int64(DATA_LENGTH_OFFSET) + 1],
            bytes[Int64(DATA_LENGTH_OFFSET) + 2],
            bytes[Int64(DATA_LENGTH_OFFSET) + 3]
        )
        if (Int64(dataLength) < 1) {
            throw InvalidDataException("Zero size tag")
        }
        return HEADER_LENGTH
    }