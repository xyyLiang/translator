    public func readBits(count: Int64): Int64 {
        if (count < 0 || count > MAXIMUM_CACHE_SIZE) {
            throw IllegalArgumentException("count must not be negative or greater than ${MAXIMUM_CACHE_SIZE}")
        }
        if (ensureCache(count)) {
            return -1
        }

        if (bitsCachedSize < count) {
            return processBitsGreater57(count)
        }
        return readCachedBits(count)
    }
