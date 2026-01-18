    init(key: String, disk: DiskLruCache) {
        this.disk = disk
        this.key = key
        this.lengths = Array<Int64>(disk.valueCount, item: 0)
    }