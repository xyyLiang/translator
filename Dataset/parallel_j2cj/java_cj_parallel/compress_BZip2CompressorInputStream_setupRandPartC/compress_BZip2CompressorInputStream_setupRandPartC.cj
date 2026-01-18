    private func setupRandPartC(): Int64 {
        if (this.su_j2 < Int64(this.su_z)) {
            this.crc.updateCRC(UInt8(this.su_ch2 & 0xff))
            this.su_j2 += 1
            return this.su_ch2
        }
        this.currentState = RAND_PART_A_STATE
        this.su_i2 += 1
        this.su_count = 0
        return setupRandPartA()
    }