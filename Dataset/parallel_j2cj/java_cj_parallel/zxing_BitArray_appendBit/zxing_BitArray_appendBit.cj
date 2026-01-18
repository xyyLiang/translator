    public func appendBit(bit: Bool) {
        ensureCapacity(this.size + 1)
        if (bit) {
            this.bits[this.size / 32] |= 1 << (this.size & 0x1F)
        }
        this.size++
    }