    private func bsW(n: Int64, v: Int64): Unit {
        var bsLiveShadow: Int64 = this.bsLive
        var bsBuffShadow: Int64 = this.bsBuff

        while (bsLiveShadow >= 8) {
            let byte = UInt8(bsBuffShadow >> 24 & 0xff)
            writeByte(byte) // write 8-bit
            bsBuffShadow <<= 8
            bsLiveShadow -= 8
        }

        this.bsBuff = bsBuffShadow | (v << (32 - bsLiveShadow - n))
        this.bsLive = bsLiveShadow + n
    }