    protected func findByte(value: UInt8, pos: Int64): Int64 {
        for (i in pos..tail) {
            if (buffer[i] == value) {
                return i
            }
        }

        return -1
    }