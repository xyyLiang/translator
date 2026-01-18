    @OverflowWrapping
    public static func byteBufferToString(bytes: Array<Byte>, offset: Int32, length: Int32): String {
        return byteBufferToString(bytes, offset, length, defaultCharsetName);
    }