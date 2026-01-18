func applyMaskPenaltyRule3(matrix: ByteMatrix): Int64 {
    var numPenalties = 0
    let array = matrix.bytes
    let width = matrix.width
    let height = matrix.height
    for (y in 0..(height - 1)) {
        let arrayY = array[y]
        for (x in 0..(width - 1)) {
            if (x + 6 < width && arrayY[x] == 1 && arrayY[x + 1] == 0 && arrayY[x + 2] == 1 && arrayY[x + 3] == 1 &&
                arrayY[x + 4] == 1 && arrayY[x + 5] == 0 && arrayY[x + 6] == 1 && (isWhiteHorizontal(arrayY, x - 4, x) ||
                isWhiteHorizontal(arrayY, x + 7, x + 11))) {
                numPenalties++
            }
            if (y + 6 < height && array[y][x] == 1 && array[y + 1][x] == 0 && array[y + 2][x] == 1 && array[y + 3][x] ==
                1 && array[y + 4][x] == 1 && array[y + 5][x] == 0 && array[y + 6][x] == 1 && (isWhiteVertical(
                array,
                x,
                y - 4,
                y
            ) || isWhiteVertical(array, x, y + 7, y + 11))) {
                numPenalties++
            }
        }
    }
    numPenalties * N3
}