    func encodeCompressedGtinWithoutAI(buf: StringBuilder, currentPos: Int64, initialBufferPosition: Int64) {
        for (i in 0..4) {
            let currentBlock = this.generalDecoder.extractNumericValueFromBitArray(currentPos + 10 * i, 10)
            if (currentBlock / 100 == 0) {
                buf.append('0')
            }
            if (currentBlock / 10 == 0) {
                buf.append('0')
            }
            buf.append(currentBlock)
        }

        appendCheckDigit(buf, initialBufferPosition)
    }