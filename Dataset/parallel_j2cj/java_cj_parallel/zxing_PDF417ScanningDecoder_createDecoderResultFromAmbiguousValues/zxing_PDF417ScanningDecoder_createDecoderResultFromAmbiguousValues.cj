    static func createDecoderResultFromAmbiguousValues(
        ecLevel: Int64,
        codewords: Array<Int64>,
        erasureArray: Array<Int64>,
        ambiguousIndexes: Array<Int64>,
        ambiguousIndexValues: Array<Array<Int64>>
    ): ?DecoderResult {
        let ambiguousIndexCount = Array<Int64>(ambiguousIndexes.size, item: 0)
        for (tries in 100..0 : -1) {
            for (i in 0..ambiguousIndexCount.size) {
                codewords[ambiguousIndexes[i]] = ambiguousIndexValues[i][ambiguousIndexCount[i]]
            }
            try {
                return decodeCodewords(codewords, ecLevel, erasureArray)
            } catch (ignored: ChecksumException) {}
            if (ambiguousIndexCount.size == 0) {
                throw ChecksumException()
            }
            for (i in 0..ambiguousIndexCount.size) {
                if (ambiguousIndexCount[i] < ambiguousIndexValues[i].size - 1) {
                    ambiguousIndexCount[i] += 1
                    break
                } else {
                    ambiguousIndexCount[i] = 0
                    if (i == ambiguousIndexCount.size - 1) {
                        throw ChecksumException()
                    }
                }
            }
        }
        throw ChecksumException()
    }