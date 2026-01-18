    @OverflowWrapping
    public static func stringToByteBufferIgnoringEncodingIssues(s: String, offset: Int64, length: Int64): Option<Array<Byte>> {
        try {
            return stringToByteBuffer(s, offset, length)
        } catch (e: Exception) {
            return Option<Array<Byte>>.None
        }
    }