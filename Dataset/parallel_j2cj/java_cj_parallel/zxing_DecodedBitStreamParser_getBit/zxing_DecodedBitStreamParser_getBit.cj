    static func getBit(obit: Int64, bytes: Array<UInt8>): Int64 {
        let bit = obit - 1
        if ((bytes[bit / 6] & (1 << (5 - (bit % 6)))) == 0) {
            0
        } else {
            1
        }
    }