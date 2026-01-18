func makeTypeInfoBits(ecLevel: ErrorCorrectionLevel, maskPattern: Int64, bits: BitArray) {
    if (!isValidMaskPattern(maskPattern)) {
        throw WriterException("Invalid mask pattern")
    }
    let typeInfo = (ecLevel.bits() << 3) | maskPattern
    bits.appendBits(typeInfo, 5)

    let bchCode = calculateBCHCode(typeInfo, TYPE_INFO_POLY)
    bits.appendBits(bchCode, 10)

    let maskBits = BitArray()
    maskBits.appendBits(TYPE_INFO_MASK_PATTERN, 15)
    bits.xor(maskBits)

    if (bits.size != 15) {
        throw WriterException("should not happen but we got: ${bits.size}")
    }
}
