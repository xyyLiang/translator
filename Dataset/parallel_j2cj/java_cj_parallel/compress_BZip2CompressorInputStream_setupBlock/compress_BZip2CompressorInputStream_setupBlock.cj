    private func setupBlock(): Int64 {
        if (currentState == EOF || this.data.isNone()) {
            return -1
        }

        let cftab: Array<Int64> = this.data().cftab
        let ttLen: Int64 = this.last + 1
        let tt: Array<Int64> = this.data().initTT(ttLen)
        let ll8: Array<UInt8> = this.data().ll8
        cftab[0] = 0

        this.data().unzftab.copyTo(cftab, 0, 1, 256)

        var c: Int64 = cftab[0]
        for (i in 1..=256) {
            c += cftab[i]
            cftab[i] = c
        }

        for (i in 0..=this.last) {
            let tmp: Int64 = cftab[ll8[i]]
            cftab[ll8[i]] += 1
            checkBounds(tmp, ttLen, ttindex)
            tt[tmp] = i
        }

        if (this.origPtr < 0 || this.origPtr >= tt.size) {
            throw CompressorException("Stream corrupted")
        }

        this.su_tPos = tt[this.origPtr]
        this.su_count = 0
        this.su_i2 = 0
        this.su_ch2 = 256 //not a char and not EOF

        if (this.blockRandomised) {
            this.su_rNToGo = 0
            this.su_rTPos = 0
            return setupRandPartA()
        }
        return setupNoRandPartA()
    }