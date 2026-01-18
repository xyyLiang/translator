    public func rotate90() {
        let newWidth = height
        let newHeight = width
        let newRowSize = (newWidth + 31) / 32
        let newBits = Array<Int64>(newRowSize * newHeight, item: 0)

        for (y in 0..height) {
            for (x in 0..width) {
                let offset = y * rowSize + (x / 32)
                if ((Int64(UInt64(bits[offset]) >> (x & 0x1f)) & 1) != 0) {
                    let newOffset = (newHeight - 1 - x) * newRowSize + (y / 32)
                    newBits[newOffset] |= 1 << (y & 0x1f)
                }
            }
        }
        this.width = newWidth
        this.height = newHeight
        this.rowSize = newRowSize
        this.bits = newBits
    }