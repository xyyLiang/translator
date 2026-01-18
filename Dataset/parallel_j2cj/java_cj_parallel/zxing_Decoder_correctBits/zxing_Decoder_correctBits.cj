    func correctBits(rawbits: Array<Bool>): CorrectedBitsResult {
        let (gf, codewordSize) = if (ddata.nbLayers <= 2) {
            (GenericGF.AZTEC_DATA_6, 6)
        } else if (ddata.nbLayers <= 8) {
            (GenericGF.AZTEC_DATA_8, 8)
        } else if (ddata.nbLayers <= 22) {
            (GenericGF.AZTEC_DATA_10, 10)
        } else {
            (GenericGF.AZTEC_DATA_12, 12)
        }
        let numDataCodewords = ddata.nbDatablocks
        let numCodewords = rawbits.size / codewordSize
        if (numCodewords < numDataCodewords) {
            throw FormatException()
        }
        var offset = rawbits.size % codewordSize
        let dataWords = Array<Int64>(numCodewords, item: 0)
        for (i in 0..numCodewords) {
            dataWords[i] = readCode(rawbits, offset, codewordSize)
            offset += codewordSize
        }

        try {
            let rsDecoder = ReedSolomonDecoder(gf)
            rsDecoder.decode(dataWords, numCodewords - numDataCodewords)
        } catch (ex: ReedSolomonException) {
            throw FormatException(ex.toString())
        }
        let mask = (1 << codewordSize) - 1
        var stuffedBits = 0
        for (i in 0..numDataCodewords) {
            let dataWord = dataWords[i]
            if (dataWord == 0 || dataWord == mask) {
                throw FormatException()
            } else if (dataWord == 1 || dataWord == mask - 1) {
                stuffedBits++
            }
        }
        let correctedBits = Array<Bool>(numDataCodewords * codewordSize - stuffedBits, item: false)
        var index = 0
        for (i in 0..numDataCodewords) {
            let dataWord = dataWords[i]
            if (dataWord == 1 || dataWord == mask - 1) {
                let val = dataWord > 1
                for (j in index..(index + codewordSize - 1)) {
                    correctedBits[j] = val
                }
                index += codewordSize - 1
            } else {
                for (bit in (codewordSize - 1)..-1 : -1) {
                    correctedBits[index] = (dataWord & (1 << bit)) != 0
                    index++
                }
            }
        }
        CorrectedBitsResult(correctedBits, 100 * (numCodewords - numDataCodewords) / numCodewords)
    }