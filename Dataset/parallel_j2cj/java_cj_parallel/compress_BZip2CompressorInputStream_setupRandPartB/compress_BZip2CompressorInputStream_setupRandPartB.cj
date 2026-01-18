    private func setupRandPartB(): Int64 {
        if (this.su_ch2 != this.su_chPrev) {
            this.currentState = RAND_PART_A_STATE
            this.su_count = 1
            return setupRandPartA()
        }
        this.su_count += 1
        if (this.su_count < 4) {
            this.currentState = RAND_PART_A_STATE
            return setupRandPartA()
        }
        this.su_z = this.data().ll8[this.su_tPos]
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
        this.su_j2 = 0
        this.currentState = RAND_PART_C_STATE
        if (this.su_rNToGo == 1) {
            this.su_z ^= 1
        }
        return setupRandPartC()
    }