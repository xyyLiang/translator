func embedHorizontalSeparationPattern(xStart: Int64, yStart: Int64, matrix: ByteMatrix) {
    for (x in 0..8) {
        if (!isEmpty(matrix.get(xStart + x, yStart))) {
            throw WriterException()
        }
        matrix.set(xStart + x, yStart, 0)
    }
}