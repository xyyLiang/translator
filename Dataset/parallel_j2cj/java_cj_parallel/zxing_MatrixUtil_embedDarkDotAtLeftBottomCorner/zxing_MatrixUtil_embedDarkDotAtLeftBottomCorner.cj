func embedDarkDotAtLeftBottomCorner(matrix: ByteMatrix) {
    if (matrix.get(8, matrix.height - 8) == 0) {
        throw WriterException()
    }
    matrix.set(8, matrix.height - 8, 1)
}