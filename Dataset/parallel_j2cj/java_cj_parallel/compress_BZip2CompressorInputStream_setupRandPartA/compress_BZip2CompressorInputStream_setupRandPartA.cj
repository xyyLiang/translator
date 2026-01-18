    private func setupRandPartA(): Int64 {
        if (this.su_i2 <= this.last) {
            this.su_chPrev = this.su_ch2
            var su_ch2Shadow: Int64 = Int64(this.data().ll8[this.su_tPos])
            checkBounds(this.su_tPos, this.data().tt.size, sutPos)
            this.su_tPos = this.data().tt[this.su_tPos]
            if (this.su_rNToGo == 0) {
                this.su_rNToGo = Rand.rNums(this.su_rTPos) - 1
                this.su_rTPos += 1
                if (this.su_rTPos == 512) {
                    this.su_rTPos = 0
                }
            } else {
                this.su_rNToGo -= 1
            }
            su_ch2Shadow ^= if (this.su_rNToGo == 1) {
                1
            } else {
                0
            }
            this.su_ch2 = su_ch2Shadow
            this.su_i2 += 1
            this.currentState = RAND_PART_B_STATE
            this.crc.updateCRC(UInt8(su_ch2Shadow & 0xff))
            return su_ch2Shadow
        }
        endBlock()
        initBlock()
        return setupBlock()
    }