func maybeEmbedVersionInfo(version: Version, matrix: ByteMatrix) {
    if (version.versionNumber < 7) { 
        return 
    }
    let versionInfoBits = BitArray()
    makeVersionInfoBits(version, versionInfoBits)

    var bitIndex = 6 * 3 - 1

    for (i in 0..6) {
        for (j in 0..3) {
            let bit = versionInfoBits.get(bitIndex)
            bitIndex--

            matrix.set(i, matrix.height - 11 + j, bit)

            matrix.set(matrix.height - 11 + j, i, bit)
        }
    }
}
