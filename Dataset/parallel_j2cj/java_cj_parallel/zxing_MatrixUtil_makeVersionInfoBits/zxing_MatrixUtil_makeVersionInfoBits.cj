func makeVersionInfoBits(version: Version, bits: BitArray) {
    bits.appendBits(version.versionNumber, 6)
    let bchCode = calculateBCHCode(version.versionNumber, VERSION_INFO_POLY)
    bits.appendBits(bchCode, 12)

    if (bits.size != 18) {
        throw WriterException("should not happen but we got: ${bits.size}")
    }
}
