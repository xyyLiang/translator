func embedPositionDetectionPatternsAndSeparators(matrix: ByteMatrix) {
    let pdpWidth = POSITION_DETECTION_PATTERN[0].size

    embedPositionDetectionPattern(0, 0, matrix)

    embedPositionDetectionPattern(matrix.width - pdpWidth, 0, matrix)

    embedPositionDetectionPattern(0, matrix.width - pdpWidth, matrix)

    let hspWidth = 8

    embedHorizontalSeparationPattern(0, hspWidth - 1, matrix)

    embedHorizontalSeparationPattern(
        matrix.width - hspWidth,
        hspWidth - 1,
        matrix
    )

    embedHorizontalSeparationPattern(0, matrix.width - hspWidth, matrix)

    let vspSize = 7

    embedVerticalSeparationPattern(vspSize, 0, matrix)

    embedVerticalSeparationPattern(matrix.height - vspSize - 1, 0, matrix)

    embedVerticalSeparationPattern(vspSize, matrix.height - vspSize, matrix)
}