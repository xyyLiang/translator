    static func appendCheckDigit(buf: StringBuilder, currentPos: Int64) {
        var checkDigit = 0
        for (i in 0..13) {
            let digit = Int64(UInt32(buf.get(i + currentPos).getOrThrow()) - UInt32('0'))
            checkDigit += if ((i & 0x01) == 0) {
                3 * digit
            } else {
                digit
            }
        }

        checkDigit = 10 - (checkDigit % 10)
        if (checkDigit == 10) {
            checkDigit = 0
        }

        buf.append(checkDigit)
    }