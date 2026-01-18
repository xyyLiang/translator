func buildMatrix(
    dataBits: BitArray,
    ecLevel: ErrorCorrectionLevel,
    version: Version,
    maskPattern: Int64,
    matrix: ByteMatrix
) {
    clearMatrix(matrix)
    embedBasicPatterns(version, matrix)
    embedTypeInfo(ecLevel, maskPattern, matrix)
    maybeEmbedVersionInfo(version, matrix)
    embedDataBits(dataBits, maskPattern, matrix)
}
