    public func timestamp(): Int64 {
        if (version() != 1) {
            throw UnsupportedOperationException("Not a time-based UUID")
        }
        let timestampBytes = Array<Byte>(8, item: 0)
        this.bytes.copyTo(timestampBytes, 6, 0, 2)
        this.bytes.copyTo(timestampBytes, 4, 2, 2)
        this.bytes.copyTo(timestampBytes, 0, 4, 4)
        timestampBytes[0] &= 0x0f
        Int64.parse("0x" + toHexString(timestampBytes))
    }  