    public func readBits(oNumBits: Int64): Int64 {
        var numBits = oNumBits
        if (numBits < 1 || numBits > 32 || numBits > available()) {
            throw IllegalArgumentException("${numBits}")
        }

        var result = 0

        if (bitOffset > 0) {
            let bitsLeft = 8 - bitOffset
            let toRead = math.min(numBits, bitsLeft)
            let bitsToNotRead = bitsLeft - toRead
            let mask = (0xFF >> (8 - toRead)) << bitsToNotRead
            result = (Int64(bytes[byteOffset]) & mask) >> bitsToNotRead
            numBits -= toRead
            bitOffset += toRead
            if (bitOffset == 8) {
                bitOffset = 0
                byteOffset++
            }
        }

        if (numBits > 0) {
            while (numBits >= 8) {
                result = (result << 8) | (Int64(bytes[byteOffset]) & 0xFF)
                byteOffset++
                numBits -= 8
            }

            if (numBits > 0) {
                let bitsToNotRead = 8 - numBits
                let mask = (0xFF >> bitsToNotRead) << bitsToNotRead
                result = (result << numBits) | ((Int64(bytes[byteOffset]) & mask) >> bitsToNotRead)
                bitOffset += numBits
            }
        }

        result
    }