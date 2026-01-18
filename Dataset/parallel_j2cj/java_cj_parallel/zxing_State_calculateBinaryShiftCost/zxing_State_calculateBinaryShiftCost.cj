    static func calculateBinaryShiftCost(binaryShiftByteCount: Int64): Int64 {
        if (binaryShiftByteCount > 62) {
            21
        } else if (binaryShiftByteCount > 31) {
            20
        } else if (binaryShiftByteCount > 0) {
            10
        } else {
            0
        }
    }