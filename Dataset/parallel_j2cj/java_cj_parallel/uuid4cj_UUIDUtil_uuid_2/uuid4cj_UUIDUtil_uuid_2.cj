    public static func uuid(bytes: Array<Int8>, offset: Int32): UUID {
        checkUUIDByteArray(bytes, offset)
        return UUID(Int8ToUInt8(bytes.slice(Int64(offset), 16)))
    }