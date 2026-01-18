    func readCodewords(): Array<UInt8> {
        let formatInfo = readFormatInformation()
        let version = readVersion()

        let dataMask = DataMask.parse(Int64(formatInfo.dataMask))
        let dimension = this.bitMatrix.height
        dataMask.unmaskBitMatrix(bitMatrix, dimension)

        let functionPattern = version.buildFunctionPattern()

        var readingUp = true
        let result = Array<UInt8>(version.totalCodewords, item: 0)
        var resultOffset = 0
        var currentByte = 0
        var bitsRead = 0
        var j = dimension - 1
        while (j > 0) {
            if (j == 6) {
                j--
            }
            for (count in 0..dimension) {
                let i = if (readingUp) {
                    dimension - 1 - count
                } else {
                    count
                }
                for (col in 0..2) {
                    if (!functionPattern.get(j - col, i)) {
                        bitsRead++
                        currentByte <<= 1
                        if (bitMatrix.get(j - col, i)) {
                            currentByte |= 1
                        }
                        if (bitsRead == 8) {
                            result[resultOffset] = UInt8(currentByte)
                            resultOffset++
                            bitsRead = 0
                            currentByte = 0
                        }
                    }
                }
            }
            readingUp = !readingUp
            j -= 2
        }
        if (resultOffset != version.totalCodewords) {
            throw FormatException()
        }
        result
    }