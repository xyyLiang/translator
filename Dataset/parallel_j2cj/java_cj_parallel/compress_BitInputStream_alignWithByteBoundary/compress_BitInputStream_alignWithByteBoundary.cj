    public func alignWithByteBoundary(): Unit {
        let toSkip: Int64 = bitsCachedSize % 8
        if (toSkip > 0) {
            readCachedBits(toSkip)
        }
    }