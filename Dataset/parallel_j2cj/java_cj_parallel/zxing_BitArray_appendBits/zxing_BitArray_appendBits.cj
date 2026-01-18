    public func appendBits(value: Int64, numBits: Int64) {
        if (numBits < 0 || numBits > 32) {
            throw IllegalArgumentException("Num bits must be between 0 and 32")
        }
        var nextSize = this.size
        ensureCapacity(nextSize + numBits)
        for (numBitsLeft in (numBits - 1)..=0 : -1) {
            if ((value & (1 << numBitsLeft)) != 0) {
                this.bits[nextSize / 32] |= 1 << (nextSize & 0x1F)
            }
            nextSize++
        }
        this.size = nextSize
    }