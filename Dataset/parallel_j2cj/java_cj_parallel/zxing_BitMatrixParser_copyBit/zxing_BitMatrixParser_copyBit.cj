    func copyBit(i: Int64, j: Int64, versionBits: Int64) {
        let bit = if (this.mirror) {
            this.bitMatrix.get(j, i)
        } else {
            this.bitMatrix.get(i, j)
        }
        if (bit) {
            (versionBits << 1) | 0x1
        } else {
            versionBits << 1
        }
    }