func decodeAlphanumericSegment(
    bits: BitSource,
    result: StringBuilder,
    oCount: Int64,
    fc1InEffect: Bool
) {
    var count = oCount
    let start = result.size
    while (count > 1) {
        if (bits.available() < 11) {
            throw FormatException()
        }
        let nextTwoCharsBits = bits.readBits(11)
        result.append(toAlphaNumericChar(nextTwoCharsBits / 45))
        result.append(toAlphaNumericChar(nextTwoCharsBits % 45))
        count -= 2
    }
    if (count == 1) {
        if (bits.available() < 6) {
            throw FormatException()
        }
        result.append(toAlphaNumericChar(bits.readBits(6)))
    }
    if (fc1InEffect) {
        for (i in start..result.size) {
            if (result.get(i).getOrThrow() == '%') {
                if (i < result.size - 1 && result.get(i + 1).getOrThrow() == '%') {
                    result.remove(i + 1)
                } else {
                    result.remove(i)
                    result.insert(i, Char(0x1D))
                }
            }
        }
    }
}