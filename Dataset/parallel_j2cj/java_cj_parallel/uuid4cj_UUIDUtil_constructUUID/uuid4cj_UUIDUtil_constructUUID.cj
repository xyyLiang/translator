    @OverflowWrapping
    public static func constructUUID(types: UUIDType, uuidBytes: Array<Int8>): UUID {
        // first, ensure type is ok
        var b: Int32 = Int32(uuidBytes[Int64(BYTE_OFFSET_TYPE)] & 0xF) // clear out high nibble
        b |= Int32(types.raw() << 4)
        uuidBytes[Int64(BYTE_OFFSET_TYPE)] = Int8(b)
        // second, ensure variant is properly set too
        b = Int32(uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_VARIATION)] & 0x3F) // remove 2 MSB
        b |= 0x80 // set as '10'
        uuidBytes[Int64(BYTE_OFFSET_VARIATION)] = Int8(b)
        return uuid(uuidBytes)
    }