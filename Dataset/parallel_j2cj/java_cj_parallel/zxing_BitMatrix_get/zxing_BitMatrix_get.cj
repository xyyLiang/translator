    public func get(x: Int64, y: Int64): Bool {
        (Int64(UInt64(this.bits[y * this.rowSize + (x / 32)]) >> (x & 0x1f)) & 1) != 0
    }