    public func row(y: Int64, r: ?BitArray): BitArray {
        let row = if (let Some(m) = r) {
            if (m.size < width) {
                BitArray(this.width)
            } else {
                m.clear()
                m
            }
        } else {
            BitArray(this.width)
        }
        let offset = y * this.rowSize
        for (x in 0..this.rowSize) {
            row.setBulk(x * 32, this.bits[offset + x])
        }
        row
    }