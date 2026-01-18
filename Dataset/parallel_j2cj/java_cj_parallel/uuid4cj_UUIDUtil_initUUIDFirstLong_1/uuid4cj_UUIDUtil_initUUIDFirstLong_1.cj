    public static func initUUIDFirstLong(l1: Int64, rawType: Int32): Int64 {
        var ll1: Int64 = l1
        ll1 &= (!0xF000) // remove high nibble of 6th byte
        ll1 |= Int64(rawType << 12)
        return ll1
    }