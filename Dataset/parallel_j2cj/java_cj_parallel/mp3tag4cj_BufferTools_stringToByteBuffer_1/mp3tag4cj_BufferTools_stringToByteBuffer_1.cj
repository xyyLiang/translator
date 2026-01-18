    @OverflowWrapping
    public static func stringToByteBuffer(s: String, offset: Int64, length: Int64, _: String): Array<Byte> {
        var stringToCopy: String = s[offset..length + offset]
        return stringToCopy.toArray()
    }