func decodeHanziSegment(
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
        var assembledTwoBytes = ((twoBytes / 0x060) << 8) | (twoBytes % 0x060)
        if (assembledTwoBytes < 0x00A00) {
            assembledTwoBytes += 0x0A1A1
        } else {
            assembledTwoBytes += 0x0A6A1
        }
        buffer[offset] = UInt8((assembledTwoBytes >> 8) & 0xFF)
        buffer[offset + 1] = UInt8(assembledTwoBytes & 0xFF)
        offset += 2
        count--
    }

    result.appendFromUtf8(buffer)
}