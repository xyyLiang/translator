    public static func isEqual(
        buffer1: Array<Byte>, offset1: Int64, length1: Int64,
        buffer2: Array<Byte>, offset2: Int64, length2: Int64,
        ignoreTrailingNulls: Bool): Bool {
        let minLen: Int64 = if (length1 < length2) {
            length1
        } else {
            length2
        }
        for (i in 0..minLen where buffer1[offset1 + i] != buffer2[offset2 + i]) {
            return false
        }
        if (length1 == length2) {
            return true
        }
        if (ignoreTrailingNulls) {
            if (length1 > length2) {
                for (i in length2..length1 where buffer1[offset1 + i] != 0) {
                    return false
                }
            } else {
                for (i in length1..length2 where buffer2[offset2 + i] != 0) {
                    return false
                }
            }
            return true
        }
        return false
    }