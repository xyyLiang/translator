    private func makeMaps(): Unit {
        let inUse: Array<Bool> = this.data().inUse
        let seqToUnseq: Array<UInt8> = this.data().seqToUnseq

        var nInUseShadow: Int64 = 0

        for (i in 0..256) {
            if (inUse[i]) {
                seqToUnseq[nInUseShadow] = UInt8(i & 0xff)
                nInUseShadow += 1
            }
        }

        this.nInUse = nInUseShadow
    }