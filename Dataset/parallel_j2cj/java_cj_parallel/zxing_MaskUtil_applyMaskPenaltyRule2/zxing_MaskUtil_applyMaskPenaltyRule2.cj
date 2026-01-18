func applyMaskPenaltyRule2(matrix: ByteMatrix): Int64 {
    var penalty = 0
    let array = matrix.bytes
    let width = matrix.width
    let height = matrix.height
    for (y in 0..(height - 1)) {
        let arrayY = array[y]
        for (x in 0..(width - 1)) {
            let value = arrayY[x]
            if (value == arrayY[x + 1] && value == array[y + 1][x] && value == array[y + 1][x + 1]) {
                penalty++
            }
        }
    }
    N2 * penalty
}