func decodeKanjiSegment(
    bits: BitSource,
    result: StringBuilder,
    oCount: Int64
) {
    var count = oCount
    if (count * 13 > bits.available()) {
        throw FormatException()
    }

    let buffer = Array<UInt8>(2 * count, item: 0)
    var offset = 0
    while (count > 0) {
        let twoBytes = bits.readBits(13)
        var assembledTwoBytes = ((twoBytes / 0x0C0) << 8) | (twoBytes % 0x0C0)
        if (assembledTwoBytes < 0x01F00) {
            assembledTwoBytes += 0x08140
        } else {
            assembledTwoBytes += 0x0C140
        }
        buffer[offset] = UInt8(assembledTwoBytes >> 8)
        buffer[offset + 1] = UInt8(assembledTwoBytes)
        offset += 2
        count--
    }

    result.appendFromUtf8(buffer)
}