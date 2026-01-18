    static func appendAlphanumericBytes(content: String, bits: BitArray) {
        let length = content.size
        var i = 0
        while (i < length) {
            let code1 = getAlphanumericCode(Int64(UInt32(content.charAt(i))))
            if (code1 == -1) {
                throw WriterException()
            }
            if (i + 1 < length) {
                let code2 = getAlphanumericCode(Int64(UInt32(content.charAt(i + 1))))
                if (code2 == -1) {
                    throw WriterException()
                }
                bits.appendBits(code1 * 45 + code2, 11)
                i += 2
            } else {
                bits.appendBits(code1, 6)
                i++
            }
        }
    }