    @OverflowWrapping
    private static func appendInt(value: Int32, buffer: Array<Int8>, offset: Int32): Unit {
        var os: Int32 = offset
        buffer[Int64(os)] = Int8(value >> 24)
        os++
        buffer[Int64(os)] = Int8(value >> 16)
        os++
        buffer[Int64(os)] = Int8(value >> 8)
        os++
        buffer[Int64(os)] = Int8(value)
    }