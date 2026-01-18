    @OverflowWrapping
    public static func copyIntoByteBuffer(
        bytes: Array<Byte>,
        offset: Int64,
        length: Int64,
        destBuffer: Array<Byte>,
        destOffset: Int64
    ): Unit {
        if (length > 0) {
            bytes.copyTo(destBuffer, offset, destOffset, length)
        }
    }