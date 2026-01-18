    static func drawModeMessage(matrix: BitMatrix, compact: Bool, matrixSize: Int64, modeMessage: BitArray) {
        let center = matrixSize / 2
        if (compact) {
            for (i in 0..7) {
                let offset = center - 3 + i
                if (modeMessage.get(i)) {
                    matrix.set(offset, center - 5)
                }
                if (modeMessage.get(i + 7)) {
                    matrix.set(center + 5, offset)
                }
                if (modeMessage.get(20 - i)) {
                    matrix.set(offset, center + 5)
                }
                if (modeMessage.get(27 - i)) {
                    matrix.set(center - 5, offset)
                }
            }
        } else {
            for (i in 0..10) {
                let offset = center - 5 + i + i / 5
                if (modeMessage.get(i)) {
                    matrix.set(offset, center - 7)
                }
                if (modeMessage.get(i + 10)) {
                    matrix.set(center + 7, offset)
                }
                if (modeMessage.get(29 - i)) {
                    matrix.set(offset, center + 7)
                }
                if (modeMessage.get(39 - i)) {
                    matrix.set(center - 7, offset)
                }
            }
        }
    }