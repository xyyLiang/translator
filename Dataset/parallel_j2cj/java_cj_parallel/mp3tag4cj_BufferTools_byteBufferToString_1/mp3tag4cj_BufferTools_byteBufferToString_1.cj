    @OverflowWrapping
    public static func byteBufferToString(bytes: Array<Byte>, offset: Int32, length: Int32, _: String): String {
        if (length < 1) {
            return ""
        }
        unsafe {
        return String.fromUtf8Unchecked(bytes.slice(Int64(offset), Int64(length)))
        }
    }