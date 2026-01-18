func embedVerticalSeparationPattern(xStart: Int64, yStart: Int64, matrix: ByteMatrix) {
    for (y in 0..7) {
        if (!isEmpty(matrix.get(xStart, yStart + y))) {
            throw WriterException()
        }
        matrix.set(xStart, yStart + y, 0)
    }
}