    @OverflowWrapping
    public static func stringToByteBuffer(s: String, offset: Int64, length: Int64): Array<Byte> {
        return stringToByteBuffer(s, offset, length, defaultCharsetName)
    }