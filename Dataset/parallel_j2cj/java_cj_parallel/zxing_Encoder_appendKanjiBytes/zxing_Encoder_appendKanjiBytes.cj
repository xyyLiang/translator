    static func appendKanjiBytes(content: String, bits: BitArray) {
        let bytes = content.toUtf8Array()
        if (bytes.size % 2 != 0) {
            throw WriterException("Kanji byte size not even")
        }
        for (i in 0..(bytes.size - 1) : 2) {
            let byte1 = Int64(bytes[i] & 0xFF)
            let byte2 = Int64(bytes[i + 1] & 0xFF)
            let code = (byte1 << 8) | byte2
            let subtracted = if (code >= 0x8140 && code <= 0x9ffc) {
                code - 0x8140
            } else if (code >= 0xe040 && code <= 0xebbf) {
                code - 0xc140
            } else {
                -1
            }
            if (subtracted == -1) {
                throw WriterException("Invalid byte sequence")
            }
            let encoded = ((subtracted >> 8) * 0xc0) + (subtracted & 0xff)
            bits.appendBits(encoded, 13)
        }
    }