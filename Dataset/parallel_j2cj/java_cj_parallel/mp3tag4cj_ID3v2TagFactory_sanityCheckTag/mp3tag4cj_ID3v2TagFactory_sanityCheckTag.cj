    public static func sanityCheckTag(bytes: Array<Int8>): Unit {
        if (bytes.size < Int64(AbstractID3v2Tag.HEADER_LENGTH)) {
            throw NoSuchTagException("Buffer too short")
        }
        var tempStr: String = match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, 0, Int32(AbstractID3v2Tag.TAG.size))) {
            case Some(x) => x
            case None => ""
        }
        if (AbstractID3v2Tag.TAG != tempStr) {
            throw NoSuchTagException("")
        }
        var majorVersion: Int8 = bytes[Int64(AbstractID3v2Tag.MAJOR_VERSION_OFFSET)]
        if (majorVersion != 2 && majorVersion != 3 && majorVersion != 4) {
            var minorVersion: Int8 = bytes[Int64(AbstractID3v2Tag.MINOR_VERSION_OFFSET)]
            throw UnsupportedTagException("Unsupported version 2.${majorVersion}.${minorVersion}")
        }
    }