    protected func extractField(frameHeader: Int64, bitMask: Int64): Int32 {
        var shiftBy: Int64 = 0
        for (i in 0..32) {
            if (((bitMask >> i) & 1) != 0) {
                shiftBy = i
                break
            }
        }
        return Int32(((frameHeader >> shiftBy) & (bitMask >> shiftBy)))
    }