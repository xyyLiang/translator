    @OverflowWrapping
    public static func copyBuffer(bytes: Array<Byte>, offset: Int64, length: Int64): Array<Byte> {
        var copy: Array<Byte> = Array<Byte>(length, {_ => 0})
        if (length > 0) {
            bytes.copyTo(copy, offset, 0, length)
        }
        return copy
    }