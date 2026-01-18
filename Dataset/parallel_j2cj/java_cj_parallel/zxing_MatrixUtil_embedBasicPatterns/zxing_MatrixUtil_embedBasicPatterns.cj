func embedBasicPatterns(version: Version, matrix: ByteMatrix) {
    embedPositionDetectionPatternsAndSeparators(matrix)

    embedDarkDotAtLeftBottomCorner(matrix)

    maybeEmbedPositionAdjustmentPatterns(version, matrix)

    embedTimingPatterns(matrix)
}
