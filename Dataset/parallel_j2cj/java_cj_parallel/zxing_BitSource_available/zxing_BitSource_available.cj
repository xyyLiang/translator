    public func available(): Int64 {
        return 8 * (bytes.size - byteOffset) - bitOffset
    }