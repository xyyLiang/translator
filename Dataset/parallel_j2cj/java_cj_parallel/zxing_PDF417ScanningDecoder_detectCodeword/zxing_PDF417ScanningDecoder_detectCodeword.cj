    static func detectCodeword(
        image: BitMatrix,
        minColumn: Int64,
        maxColumn: Int64,
        leftToRight: Bool,
        ostartColumn: Int64,
        imageRow: Int64,
        minCodewordWidth: Int64,
        maxCodewordWidth: Int64
    ): ?Codeword {
        var startColumn = adjustCodewordStartColumn(image, minColumn, maxColumn, leftToRight, ostartColumn, imageRow)
        if (let Some(moduleBitCount) = getModuleBitCount(image, minColumn, maxColumn, leftToRight, startColumn, imageRow
        )) {
            var endColumn = 0
            var codewordBitCount = util.sum(moduleBitCount)
            if (leftToRight) {
                endColumn = startColumn + codewordBitCount
            } else {
                for (i in 0..(moduleBitCount.size / 2)) {
                    let tmpCount = moduleBitCount[i]
                    moduleBitCount[i] = moduleBitCount[moduleBitCount.size - 1 - i]
                    moduleBitCount[moduleBitCount.size - 1 - i] = tmpCount
                }
                endColumn = startColumn
                startColumn = endColumn - codewordBitCount
            }
            if (!checkCodewordSkew(codewordBitCount, minCodewordWidth, maxCodewordWidth)) {
                return None
            }
            let decodedValue = PDF417CodewordDecoder.getDecodedValue(moduleBitCount)
            let codeword = PDF417Common.getCodeword(decodedValue)
            if (codeword == -1) {
                return None
            }
            Codeword(startColumn, endColumn, getCodewordBucketNumber(decodedValue), codeword)
        } else {
            None
        }
    }