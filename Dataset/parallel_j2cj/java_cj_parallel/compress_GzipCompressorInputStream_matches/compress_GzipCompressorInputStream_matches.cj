    public static func matches(sign: Array<Byte>, len: Int32): Bool {
        return len >= 2 && sign[0] == UInt8(31) && sign[1] == UInt8(139)
    }