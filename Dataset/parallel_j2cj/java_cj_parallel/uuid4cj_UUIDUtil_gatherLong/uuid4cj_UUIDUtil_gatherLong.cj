    protected static func gatherLong(buffer: Array<Int8>, offset: Int32): Int64 {
        let hi: Int64 = (Int64(gatherInt(buffer, offset))) << 32
        let lo: Int64 = rightShift(((Int64(gatherInt(buffer, offset+4))) << 32), 32)
        return hi | lo
    }