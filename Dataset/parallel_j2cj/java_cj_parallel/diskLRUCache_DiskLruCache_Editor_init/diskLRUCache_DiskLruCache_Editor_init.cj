    init(entry: Entry, disk: DiskLruCache) {
        this.entry = entry
        this.disk = disk
        this.written = if (!entry.readable) {
            Array<Bool>(disk.valueCount, item: false)
        } else {
            Option<Array<Bool>>.None
        }
    }