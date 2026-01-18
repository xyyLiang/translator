    @OverflowWrapping
    public static func stringIntoByteBuffer(
        s: String,
        offset: Int64,
        length: Int64,
        bytes: Array<Byte>,
        destOffset: Int64,
        _: String
    ): Unit {
        var stringToCopy: String = s[offset..offset + length]
        var srcBytes: Array<UInt8> = stringToCopy.toArray()
        if (srcBytes.size > 0) {
            srcBytes.copyTo(bytes, offset, destOffset, Int64(srcBytes.size))
        }
    }