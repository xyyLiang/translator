func applyMaskPenaltyRule1Internal(matrix: ByteMatrix, isHorizontal: Bool): Int64 {
    var penalty = 0
    let (iLimit, jLimit) = if (isHorizontal) {
        (matrix.height, matrix.width)
    } else {
        (matrix.width, matrix.height)
    }
    let array = matrix.bytes
    for (i in 0..iLimit) {
        var numSameBitCells = 0
        var prevBit = -1
        for (j in 0..jLimit) {
            let bit = Int64(if (isHorizontal) {
                    array[i][j]
                } else {
                    array[j][i]
                })
            if (bit == prevBit) {
                numSameBitCells++
            } else {
                if (numSameBitCells >= 5) {
                    penalty += N1 + (numSameBitCells - 5)
                }
                numSameBitCells = 1
                prevBit = bit
            }
        }
        if (numSameBitCells >= 5) {
            penalty += N1 + (numSameBitCells - 5)
        }
    }
    return penalty
}
