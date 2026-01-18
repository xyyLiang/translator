    @OverflowWrapping
    public static func packInteger(i: Int32): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(4, {_ => 0})
        bytes[3] = Int8(i & (0xff))
        bytes[2] = Int8((i >> 8) & 0xff)
        bytes[1] = Int8((i >> 16) & 0xff)
        bytes[0] = Int8((i >> 24) & 0xff)
        return bytes
    }