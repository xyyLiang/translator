    private func setupNoRandPartA(): Int64 {
        if (this.su_i2 <= this.last) {
            this.su_chPrev = this.su_ch2
            let su_ch2Shadow: Int64 = Int64(this.data().ll8[this.su_tPos])
            this.su_ch2 = su_ch2Shadow
            checkBounds(this.su_tPos, this.data().tt.size, sutPos)
            this.su_tPos = this.data().tt[this.su_tPos]
            this.su_i2 += 1
            this.currentState = NO_RAND_PART_B_STATE
            this.crc.updateCRC(UInt8(su_ch2Shadow & 0xff))
            return su_ch2Shadow
        }
        this.currentState = NO_RAND_PART_A_STATE
        endBlock()
        initBlock()
        return setupBlock()
    }