    public func newOutputStream(index: Int64): File {
        synchronized(disk.lock) {
            if(!refEq(entry.currentEditor.getOrThrow(), this)) {
                throw DiskLruCacheException("editor object inconsistency")
            }
            if (!entry.readable) {
                let writtense = written.getOrThrow()
                writtense[index] = true
            }
            let dirtyFile: File = entry.getDirtyFile(index)
            return dirtyFile
        }
    }