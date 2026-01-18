    init(key: String, sequenceNumber: Int64, ins: Array<File>, lengths: Array<Int64>, disk: DiskLruCache) {
        this.key = key
        this.sequenceNumber = sequenceNumber
        this.ins = ins
        this.lengths = lengths
        this.disk = disk
    }