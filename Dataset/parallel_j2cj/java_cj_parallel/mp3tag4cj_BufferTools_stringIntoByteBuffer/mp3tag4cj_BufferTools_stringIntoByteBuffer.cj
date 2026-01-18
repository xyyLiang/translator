    @OverflowWrapping
    public static func stringIntoByteBuffer(
        s: String,
        offset: Int64,
        length: Int64,
        bytes: Array<Byte>,
        destOffset: Int64
    ): Unit {
        stringIntoByteBuffer(s, offset, length, bytes, destOffset, defaultCharsetName)
    }