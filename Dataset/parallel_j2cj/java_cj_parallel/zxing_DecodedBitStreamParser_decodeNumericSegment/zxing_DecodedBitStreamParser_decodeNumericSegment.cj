func decodeNumericSegment(
    bits: BitSource,
    result: StringBuilder,
    oCount: Int64
) {
    var count = oCount
    while (count >= 3) {
        if (bits.available() < 10) {
            throw FormatException()
        }
        let threeDigitsBits = bits.readBits(10)
        if (threeDigitsBits >= 1000) {
            throw FormatException()
        }
        result.append(toAlphaNumericChar(threeDigitsBits / 100))
        result.append(toAlphaNumericChar((threeDigitsBits / 10) % 10))
        result.append(toAlphaNumericChar(threeDigitsBits % 10))
        count -= 3
    }
    if (count == 2) {
        if (bits.available() < 7) {
            throw FormatException()
        }
        let twoDigitsBits = bits.readBits(7)
        if (twoDigitsBits >= 100) {
            throw FormatException()
        }
        result.append(toAlphaNumericChar(twoDigitsBits / 10))
        result.append(toAlphaNumericChar(twoDigitsBits % 10))
    } else if (count == 1) {
        if (bits.available() < 4) {
            throw FormatException()
        }
        let digitBits = bits.readBits(4)
        if (digitBits >= 10) {
            throw FormatException()
        }
        result.append(toAlphaNumericChar(digitBits))
    }
}