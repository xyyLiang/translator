func maybeEmbedPositionAdjustmentPatterns(version: Version, matrix: ByteMatrix) {
    if (version.versionNumber < 2) {
        return
    }
    let index = version.versionNumber - 1
    let coordinates = POSITION_ADJUSTMENT_PATTERN_COORDINATE_TABLE[index]
    for (y in coordinates) {
        if (y >= 0) {
            for (x in coordinates) {
                if (x >= 0 && isEmpty(matrix.get(x, y))) {
                    embedPositionAdjustmentPattern(x - 2, y - 2, matrix)
                }
            }
        }
    }
}