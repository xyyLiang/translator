func applyMaskPenaltyRule4(matrix: ByteMatrix): Int64 {
    var numDarkCells = 0
    let array = matrix.bytes
    let width = matrix.width
    let height = matrix.height
    for (y in 0..(height - 1)) {
        let arrayY = array[y]
        for (x in 0..(width - 1)) {
            if (arrayY[x] == 1) {
                numDarkCells++
            }
        }
    }
    let numTotalCells = matrix.height * matrix.width
    let fivePercentVariances = math.abs(numDarkCells * 2 - numTotalCells) * 10 / numTotalCells
    fivePercentVariances * N4
}