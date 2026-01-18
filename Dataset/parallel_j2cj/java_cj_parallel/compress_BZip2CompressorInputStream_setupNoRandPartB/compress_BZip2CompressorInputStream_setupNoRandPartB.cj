    private func setupNoRandPartB(): Int64 {
        if (this.su_ch2 != this.su_chPrev) {
            this.su_count = 1
            return setupNoRandPartA()
        }
        this.su_count += 1
        if (this.su_count >= 4) {
            checkBounds(this.su_tPos, this.data().ll8.size, sutPos)
            this.su_z = this.data().ll8[this.su_tPos]
            this.su_tPos = this.data().tt[this.su_tPos]
            this.su_j2 = 0
            return setupNoRandPartC()
        }
        return setupNoRandPartA()
    }