    private func setupNoRandPartC(): Int64 {
        if (this.su_j2 < Int64(this.su_z)) {
            let su_ch2Shadow: Int64 = this.su_ch2
            this.crc.updateCRC(UInt8(su_ch2Shadow & 0xff))
            this.su_j2 += 1
            this.currentState = NO_RAND_PART_C_STATE
            return su_ch2Shadow
        }
        this.su_i2 += 1
        this.su_count = 0
        return setupNoRandPartA()
    }