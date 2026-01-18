    public static func packSynchsafeInteger(i: Int32, bytes: Array<Int8>, offset: Int32): Unit {
        bytes[Int64(offset) + 3] = Int8(i & 127)
        bytes[Int64(offset) + 2] = Int8((i >> 7) & 127)
        bytes[Int64(offset) + 1] = Int8((i >> 14) & 127)
        bytes[Int64(offset) + 0] = Int8((i >> 21) & 127)
    }