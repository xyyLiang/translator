func embedPositionAdjustmentPattern(xStart: Int64, yStart: Int64, matrix: ByteMatrix) {
    for (y in 0..5) {
        let patternY = POSITION_ADJUSTMENT_PATTERN[y]
        for (x in 0..5) {
            matrix.set(xStart + x, yStart + y, patternY[x])
        }
    }
}