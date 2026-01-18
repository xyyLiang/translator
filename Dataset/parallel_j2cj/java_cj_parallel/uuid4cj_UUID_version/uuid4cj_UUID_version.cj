    public func version(): Int32 {
        return Int32(bytes[6] >> 4 & 0x0f)
    }