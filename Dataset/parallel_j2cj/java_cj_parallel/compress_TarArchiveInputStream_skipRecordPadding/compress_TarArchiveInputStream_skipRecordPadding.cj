    private func skipRecordPadding(): Unit {
        if (!isDirectory() && this.entrySize > 0 && this.entrySize % this.recordSize != 0) {
            let available: Int64 = 0
            let numRecords: Int64 = (this.entrySize / this.recordSize) + 1
            let padding: Int64 = (numRecords * this.recordSize) - this.entrySize
            var skipped: Int64 = skip(inputStream, padding)
            skipped = this.getActuallySkipped(available, skipped, padding)

            this.count(skipped)
        }
    }