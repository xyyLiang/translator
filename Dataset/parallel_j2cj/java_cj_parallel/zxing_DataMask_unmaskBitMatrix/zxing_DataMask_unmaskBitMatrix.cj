    func unmaskBitMatrix(bits: BitMatrix, dimension: Int64) {
        for (i in 0..dimension) {
            for (j in 0..dimension) {
                if (isMasked(i, j)) {
                    bits.flip(j, i)
                }
            }
        }
    }