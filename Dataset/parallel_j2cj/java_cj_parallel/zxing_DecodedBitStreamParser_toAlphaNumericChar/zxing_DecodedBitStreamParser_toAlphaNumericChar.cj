func toAlphaNumericChar(value: Int64): Char {
    if (value >= DecodedBitStreamParser.ALPHANUMERIC_CHARS.size) {
        throw FormatException()
    }
    DecodedBitStreamParser.ALPHANUMERIC_CHARS[value]
}