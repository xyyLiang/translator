    private func checkNotClosed(): Unit {
        match (journalWriter) {
            case Some(_) => ()
            case None => 
                throw DiskLruCacheException("cache is closed")
        }
    }