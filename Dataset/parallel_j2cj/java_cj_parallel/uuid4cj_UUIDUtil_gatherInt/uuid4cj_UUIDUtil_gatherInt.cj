    
    private static func gatherInt(buffer: Array<Int8>, offset: Int32): Int32 {
        return Int32((Int32(Int64(buffer[Int64(offset)])) << 24) | (Int32(Int64(buffer[Int64(offset + 1)]) & 0xFF) << 16) | (Int32(Int64(buffer[Int64(offset + 2)]) & 0xFF) << 8) | Int32(Int64(buffer[Int64(offset + 3)]) & 0xFF))
    }