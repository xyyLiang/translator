    static func append8BitBytes(content: String, bits: BitArray) {
        let bytes = content.toUtf8Array()
        for (b in bytes) {
            bits.appendBits(Int64(b), 8)
        }
    }