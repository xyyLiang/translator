    public open func packTag(bytes: Array<Int8>): Unit {
        var offset: Int32 = packHeader(bytes, 0)
        if (extendedHeader) {
            offset = packExtendedHeader(bytes, offset)
        }
        offset = packFrames(bytes, offset)
        if (footer) {
            offset = packFooter(bytes, dataLength)
        }
    }