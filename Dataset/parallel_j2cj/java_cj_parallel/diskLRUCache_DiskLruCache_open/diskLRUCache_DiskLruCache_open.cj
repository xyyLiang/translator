public static func open(directory: Directory, appVersion: Int64, valueCount: Int64, maxSize: Int64): DiskLruCache {
        if (maxSize <= 0) {
            throw DiskLruCacheException("the max size of cache cannot be negative")
        }
        if (valueCount <= 0) {
            throw DiskLruCacheException("the number of values per cache entry cannot be negative")
        }

        // If a bkp file exists, use it instead.
        var backupFile = directory.info.path.join(JOURNAL_FILE_BACKUP)
        if (File.exists(backupFile)) {
            var journalFile = directory.info.path.join(JOURNAL_FILE)
            // If journal file also exists just delete backup file.
            if (File.exists(journalFile)) {
                File.delete(backupFile)
            } else {
                renameTo(backupFile, journalFile, true)
            }
        }

        // Prefer to pick up where we left off.
        var cache: DiskLruCache = DiskLruCache(directory, appVersion, valueCount, maxSize)
        if (File.exists(cache.journalFile)) {

                try {
                    cache.readJournal()
                    cache.processJournal()  
                    cache.journalWriter = ReallBufferSink(FileSink(File(cache.journalFile, Append)))
                    return cache
                } catch (e: Exception) {
                    cache.delete()
                }
            
        }

        cache = DiskLruCache(directory, appVersion, valueCount, maxSize)
        cache.rebuildJournal()
        return cache
    }