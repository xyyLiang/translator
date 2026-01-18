    protected func unpackTag(bytes: Array<Int8>): Unit {
        ID3v2TagFactory.sanityCheckTag(bytes)
        var offset: Int32 = unpackHeader(bytes)
        try {
            if (extendedHeader) {
                offset = unpackExtendedHeader(bytes, offset)
            }
            var framesLength: Int32 = dataLength
            if (footer) {
                framesLength -= 10
            }
            offset = unpackFrames(bytes, offset, framesLength)
            if (footer) {
                offset = unpackFooter(bytes, dataLength)
            }
        } catch (e: Exception) {
            throw InvalidDataException("Premature end of tag ${e}")
        }
    }