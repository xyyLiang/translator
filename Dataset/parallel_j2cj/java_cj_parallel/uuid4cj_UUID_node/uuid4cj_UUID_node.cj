    public func node(): Int64 {
        if (version() != 1) {
            throw UnsupportedOperationException("Not a time-based UUID")
        }

        return Int64.parse("0x" + toHexString(this.bytes.slice(10, 6)))
    }