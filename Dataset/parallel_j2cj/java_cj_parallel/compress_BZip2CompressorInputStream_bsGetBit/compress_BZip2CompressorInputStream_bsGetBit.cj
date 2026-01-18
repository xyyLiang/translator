    private static func bsGetBit(bin: BitInputStream): Bool {
        return bsR(bin, 1) != 0
    }