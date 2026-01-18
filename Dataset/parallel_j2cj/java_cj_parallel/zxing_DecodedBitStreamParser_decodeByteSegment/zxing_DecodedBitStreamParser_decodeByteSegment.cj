func decodeByteSegment(
    bits: BitSource,
    result: StringBuilder,
    oCount: Int64,
    byteSegments: ArrayList<Array<UInt8>>,
    hints: ?HashMap<DecodeHintType, Any>
) {
    var count = oCount
    if (8 * count > bits.available()) {
        throw FormatException()
    }

    let readBytes = Array<UInt8>(count, {n => UInt8(bits.readBits(8))})
    result.appendFromUtf8(readBytes)
    byteSegments.append(readBytes)
}