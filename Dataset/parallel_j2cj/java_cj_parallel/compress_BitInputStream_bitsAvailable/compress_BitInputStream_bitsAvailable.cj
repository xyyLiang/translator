    public func bitsAvailable(): Int64 {
        return bitsCachedSize + max(input.length, 0) * 8
    }