    func setBit(col: Int64, row: Int64, bit: Bool) {
        bits[row * numcols + col] = if (bit) {
            1
        } else {
            0
        }
    }