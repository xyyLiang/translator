    protected func isEOFRecord(record: ?Array<Byte>): Bool {
        return match(record) {
            case Some(v) => ArchiveUtils.isArrayZero(v, this.recordSize)
            case None => true
        }
    }