    public static func constructUUID(types: UUIDType, l1: Int64, l2: Int64): UUID {
        var ll1: Int64 = l1
        var ll2: Int64 = l2
        // first, ensure type is ok
        ll1 &= (!0xF000) // remove high nibble of 6th byte
        ll1 |= (types.raw() << 12)
        // second, ensure variant is properly set too (8th byte most-sig byte of second long)
        ll2 = rightShift((ll2 << 2), 2) // remove 2 MSB
        ll2 |= (2 << 62) // set 2 MSB to '10'
        let byteArrays: Array<UInt8> = Int8ToUInt8(int64asByteArray(ll1, ll2))
        return UUID(byteArrays)
    }