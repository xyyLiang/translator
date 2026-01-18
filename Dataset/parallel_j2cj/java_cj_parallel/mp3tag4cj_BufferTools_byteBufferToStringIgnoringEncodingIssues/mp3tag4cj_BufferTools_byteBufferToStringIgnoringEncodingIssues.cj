    @OverflowWrapping
    public static func byteBufferToStringIgnoringEncodingIssues(bytes: Array<Byte>, offset: Int32, length: Int32): Option<String> {
        try {
            return byteBufferToString(bytes, offset, length, defaultCharsetName)
        } catch (e: Exception) {
            return Option<String>.None
        }
    }