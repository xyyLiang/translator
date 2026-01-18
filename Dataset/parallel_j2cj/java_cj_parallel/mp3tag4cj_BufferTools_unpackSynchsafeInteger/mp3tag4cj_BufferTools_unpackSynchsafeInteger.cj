    @OverflowWrapping
    public static func unpackSynchsafeInteger(b1: Int8, b2: Int8, b3: Int8, b4: Int8): Int32 {
        var value: Int32 = Int32(Int8(b4 & 127))
        value += shiftByte(Int8(b3 & 127), -7)
        value += shiftByte(Int8(b2 & 127), -14)
        value += shiftByte(Int8(b1 & 127), -21)
        return value
    }