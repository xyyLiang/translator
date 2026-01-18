    @OverflowWrapping
    public static func unpackInteger(b1: Int8, b2: Int8, b3: Int8, b4: Int8): Int32 {
        var value: Int32 = Int32(b4) & 0xff
        value += BufferTools.shiftByte(b3, -8)
        value += BufferTools.shiftByte(b2, -16)
        value += BufferTools.shiftByte(b1, -24)
        return value
    }