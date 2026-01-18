    protected func readRecord(): ?Array<Byte> {
        let readNow: Int64 = this.inputStream.read(this.recordBuffer)
        this.count(readNow)
        if (readNow != this.recordSize) {
            return None
        }
        return this.recordBuffer
    }