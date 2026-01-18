    @overflowWrapping
    static func readByte(rawbits: Array<Bool>, startIndex: Int64): UInt8 {
        let n = rawbits.size - startIndex
        UInt8(if (n > 8) {
                readCode(rawbits, startIndex, 8)
            } else {
                readCode(rawbits, startIndex, n) << (8 - n)
            })
    }