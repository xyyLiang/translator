    public func newInputStream(index: Int64): Option<InputStream> {
        synchronized (disk.lock) {
            if(!refEq(entry.currentEditor.getOrThrow(), this)) {
                throw DiskLruCacheException("editor object inconsistency")
            }
            if (!entry.readable) {
                return Option<InputStream>.None
            }

            try {
                return Option<InputStream>.Some(entry.getCleanFile(index))
            } catch (e: Exception) {
                return Option<InputStream>.None
            }
        }
    }