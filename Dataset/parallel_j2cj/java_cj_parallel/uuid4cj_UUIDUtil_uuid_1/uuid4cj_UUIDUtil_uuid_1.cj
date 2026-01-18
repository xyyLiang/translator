    public static func uuid(bytes: Array<Int8>): UUID {
        checkUUIDByteArray(bytes, 0)
        return UUID(Int8ToUInt8(bytes.slice(0, 16)))
    }