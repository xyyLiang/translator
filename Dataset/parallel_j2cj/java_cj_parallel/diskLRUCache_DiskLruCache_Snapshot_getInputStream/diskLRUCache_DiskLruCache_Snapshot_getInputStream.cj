    public func getInputStream(index: Int64): File {
        if (isClosed) {
            throw DiskLruCacheException("stream closed")
        }
        let src = ins.get(index).getOrThrow()
        return src
    }