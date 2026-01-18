    static func adjustCodewordStartColumn(
        image: BitMatrix,
        minColumn: Int64,
        maxColumn: Int64,
        oleftToRight: Bool,
        codewordStartColumn: Int64,
        imageRow: Int64
    ): Int64 {
        var correctedStartColumn = codewordStartColumn
        var leftToRight = oleftToRight
        var increment = if (leftToRight) {
            1
        } else {
            -1
        }
        for (i in 0..2) {
            while ((if (leftToRight) {
                    correctedStartColumn >= minColumn
                } else {
                    correctedStartColumn < maxColumn
                }) && leftToRight == image.get(correctedStartColumn, imageRow)) {
                if (math.abs(codewordStartColumn - correctedStartColumn) > CODEWORD_SKEW_SIZE) {
                    return codewordStartColumn
                }
                correctedStartColumn += increment
            }
            increment = -increment
            leftToRight = !leftToRight
        }
        correctedStartColumn
    }