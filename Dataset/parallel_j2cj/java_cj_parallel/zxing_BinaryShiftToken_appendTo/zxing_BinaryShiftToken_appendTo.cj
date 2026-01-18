    func appendTo(bitArray: BitArray, text: Array<UInt8>) {
        let bsbc = binaryShiftByteCount
        for (i in 0..bsbc) {
            if (i == 0 || (i == 31 && bsbc <= 62)) {
                bitArray.appendBits(31, 5)
                if (bsbc > 62) {
                    bitArray.appendBits(bsbc - 31, 16)
                } else if (i == 0) {
                    bitArray.appendBits(math.min(bsbc, 31), 5)
                } else {
                    bitArray.appendBits(bsbc - 31, 5)
                }
            }
            bitArray.appendBits(Int64(text[binaryShiftStart + i]), 8)
        }
    }