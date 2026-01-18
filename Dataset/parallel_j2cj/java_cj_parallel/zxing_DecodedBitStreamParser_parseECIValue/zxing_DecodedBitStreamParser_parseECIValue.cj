func parseECIValue(bits: BitSource): Int64 {
    let firstByte = bits.readBits(8)
    if ((firstByte & 0x80) == 0) {
        return firstByte & 0x7F
    }
    if ((firstByte & 0xC0) == 0x80) {
        let secondByte = bits.readBits(8)
        return ((firstByte & 0x3F) << 8) | secondByte
    }
    if ((firstByte & 0xE0) == 0xC0) {
        let secondThirdBytes = bits.readBits(16)
        return ((firstByte & 0x1F) << 16) | secondThirdBytes
    }
    throw FormatException()
}