    public func appendBitArray(other: BitArray) {
        let otherSize = other.size
        ensureCapacity(size + otherSize)
        for (i in 0..otherSize) {
            appendBit(other.get(i))
        }
    }