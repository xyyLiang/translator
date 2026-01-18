    static func terminateBits(numDataBytes: Int64, bits: BitArray) {
        let capacity = numDataBytes * 8
        if (bits.size > capacity) {
            throw WriterException("data bits cannot fit in the QR Code${bits.size} > ${capacity}")
        }
        for (i in 0..4) {
            if (bits.size >= capacity) {
                break
            }
            bits.appendBit(false)
        }
        let numBitsInLastByte = bits.size & 0x07
        if (numBitsInLastByte > 0) {
            for (i in numBitsInLastByte..8) {
                bits.appendBit(false)
            }
        }

        let numPaddingBytes = numDataBytes - bits.sizeInBytes()
        for (i in 0..numPaddingBytes) {
            bits.appendBits(
                if ((i & 0x01) == 0) {
                    0xEC
                } else {
                    0x11
                },
                8
            )
        }
        if (bits.size != capacity) {
            throw WriterException("Bits size does not equal capacity")
        }
    }