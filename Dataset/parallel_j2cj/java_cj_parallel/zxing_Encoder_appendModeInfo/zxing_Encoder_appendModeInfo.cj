    static func appendModeInfo(mode: Mode, bits: BitArray) {
        bits.appendBits(mode.bits(), 4)
    }
