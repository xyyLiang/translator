    private func fillBuf(): Unit {
        let resu = this.input.read(buf)
        if (resu == 0) {
            throw DiskLruCacheException("no data readable")
        }
        this.pos = 0
        this.end = resu
    }