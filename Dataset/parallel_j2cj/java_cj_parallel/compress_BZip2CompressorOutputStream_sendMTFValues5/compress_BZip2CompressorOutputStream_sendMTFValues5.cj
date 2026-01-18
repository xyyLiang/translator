    private func sendMTFValues5(nGroups: Int64, nSelectors: Int64): Unit {
        bsW(3, nGroups)
        bsW(15, nSelectors)
        let selectorMtf: Array<Byte> = this.data.selectorMtf
        var bsLiveShadow = this.bsLive
        var bsBuffShadow = this.bsBuff

        for (i in 0..nSelectors) {
            for (_ in 0..selectorMtf[i]) {
                while (bsLiveShadow >= 8) {
                    writeByte(UInt8(bsBuffShadow >> 24 & 0xff))
                    bsBuffShadow <<= 8
                    bsLiveShadow -= 8
                }
                bsBuffShadow |= 1 << (32 - bsLiveShadow - 1)
                bsLiveShadow++
            }

            while (bsLiveShadow >= 8) {
                writeByte(UInt8(bsBuffShadow >> 24 & 0xff))
                bsBuffShadow <<= 8
                bsLiveShadow -= 8
            }

            bsLiveShadow++
        }
        this.bsBuff = bsBuffShadow
        this.bsLive = bsLiveShadow
    }