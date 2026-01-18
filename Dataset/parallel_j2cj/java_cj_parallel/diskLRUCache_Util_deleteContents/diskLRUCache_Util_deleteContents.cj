    static func deleteContents(dir: Directory): Unit {
        var files = dir.entryList()
        if (files.isEmpty()) {
            throw DiskLruCacheException("not a readable directory")
        }
        for (fil in files) {
            if (fil.isDirectory()) {
                deleteContents(Directory(fil.path))
            }
            if (fil.isFile()) {
                File.delete(fil.path)
            }
        }
    }