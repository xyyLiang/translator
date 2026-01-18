    public func unset(x: Int64, y: Int64) {
        this.bits[y * this.rowSize + (x / 32)] &= !(1 << (x & 0x1f))
    }