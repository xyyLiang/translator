    public func xor(mask: BitMatrix) {
        if (width != mask.width || height != mask.height || rowSize != mask.rowSize) {
            throw IllegalArgumentException("input matrix dimensions do not match")
        }
        let rowArray = BitArray(width)
        for (y in 0..height) {
            let offset = y * rowSize
            let row = mask.row(y, rowArray).bits
            for (x in 0..rowSize) {
                bits[offset + x] ^= row[x]
            }
        }
    }