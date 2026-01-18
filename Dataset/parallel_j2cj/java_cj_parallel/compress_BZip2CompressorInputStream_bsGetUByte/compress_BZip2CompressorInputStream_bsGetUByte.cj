    private static func bsGetUByte(bin: BitInputStream): UInt8 {
        return UInt8(bsR(bin, 8) & 0xff)
    }