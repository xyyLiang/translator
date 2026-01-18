func embedPositionDetectionPattern(xStart: Int64, yStart: Int64, matrix: ByteMatrix) {
    for (y in 0..7) {
        let patternY = POSITION_DETECTION_PATTERN[y]
        for (x in 0..7) {
            matrix.set(xStart + x, yStart + y, patternY[x])
        }
    }
}