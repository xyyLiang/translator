    private func sendMTFValues4(): Unit {
        let inUse: Array<Bool> = this.data.inUse
        let inUse16: Array<Bool> = this.data.sentMTFValues4_inUse16

        for (i in 15..=0 : -1) {
            inUse16[i] = false
            let i16: Int64 = i * 16
            for (j in 15..=0 : -1) {
                if (inUse[i16 + j]) {
                    inUse16[i] = true
                    break
                }
            }
        }

        for (i in 0..16) {
            let v = if (inUse16[i]) {
                1
            } else {
                0
            }
            bsW(1, v)
        }

        var bsLiveShadow: Int64 = this.bsLive
        var bsBuffShadow: Int64 = this.bsBuff

        for (i in 0..16) {
            if (inUse16[i]) {
                let i16: Int64 = i * 16
                for (j in 0..16) {
                    while (bsLiveShadow >= 8) {
                        writeByte(UInt8(bsBuffShadow >> 24 & 0xff))
                        bsBuffShadow <<= 8
                        bsLiveShadow -= 8
                    }
                    if (inUse[i16 + j]) {
                        bsBuffShadow |= 1 << (32 - bsLiveShadow - 1)
                    }
                    bsLiveShadow++
                }
            }
        }

        this.bsBuff = bsBuffShadow
        this.bsLive = bsLiveShadow
    }