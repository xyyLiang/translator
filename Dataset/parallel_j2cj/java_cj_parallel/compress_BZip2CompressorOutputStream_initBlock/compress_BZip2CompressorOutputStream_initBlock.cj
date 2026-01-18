    private func initBlock(): Unit {
        this.crc.initializeCRC()
        this.last = -1

        let inUse: Array<Bool> = this.data.inUse
        for (i in 255..=0 : -1) {
            inUse[i] = false
        }
    }