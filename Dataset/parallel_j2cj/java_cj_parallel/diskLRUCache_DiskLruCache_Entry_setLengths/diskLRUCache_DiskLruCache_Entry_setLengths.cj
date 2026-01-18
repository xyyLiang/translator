    public func setLengths(strings: Array<String>): Unit {
        if (strings.size != disk.valueCount) {
            throw DiskLruCacheException("unexpected journal line: ${strings.toString()}" )
        }
        
        try {
            for (i in 0..strings.size) {
                lengths[i] = Int64.parse(strings[i])
            }
        } catch (e: Exception) {
            throw DiskLruCacheException("unexpected journal line: ${strings.toString()}" )
        }
    }