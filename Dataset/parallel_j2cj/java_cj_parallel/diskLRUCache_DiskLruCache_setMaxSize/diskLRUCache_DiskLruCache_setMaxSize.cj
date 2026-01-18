    public func setMaxSize(maxSize: Int64): Unit {
        if (maxSize <= 0) {
            throw DiskLruCacheException("invalid cache size: ${maxSize}")
        }
        this.maxSize = maxSize
        cleanUp()
    }