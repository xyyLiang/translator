func embedTimingPatterns(matrix: ByteMatrix) {
    for (i in 8..(matrix.width - 8)) {
        let bit = (i + 1) % 2
        if (isEmpty(matrix.get(i, 6))) {
            matrix.set(i, 6, bit)
        }
        if (isEmpty(matrix.get(6, i))) {
            matrix.set(6, i, bit)
        }
    }
}