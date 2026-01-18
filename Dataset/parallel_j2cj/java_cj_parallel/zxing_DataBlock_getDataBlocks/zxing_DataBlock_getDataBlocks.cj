    static func getDataBlocks(rawCodewords: Array<UInt8>, version: Version): Array<DataBlock> {
        let ecBlocks = version.ecBlocks

        var totalBlocks = 0
        let ecBlockArray = ecBlocks.ecBlocks
        for (ecBlock in ecBlockArray) {
            totalBlocks += ecBlock.count
        }

        let result = Array<DataBlock>(totalBlocks, {n => DataBlock(0, [])})
        var numResultBlocks = 0
        for (ecBlock in ecBlockArray) {
            for (i in 0..ecBlock.count) {
                let numDataCodewords = ecBlock.dataCodewords
                let numBlockCodewords = ecBlocks.ecCodewords + numDataCodewords
                result[numResultBlocks] = DataBlock(numDataCodewords, [UInt8(numBlockCodewords)])
                numResultBlocks++
            }
        }

        let longerBlocksTotalCodewords = result[0].codewords.size
        let longerBlocksNumDataCodewords = longerBlocksTotalCodewords - ecBlocks.ecCodewords
        let shorterBlocksNumDataCodewords = longerBlocksNumDataCodewords - 1

        var rawCodewordsOffset = 0
        for (i in 0..shorterBlocksNumDataCodewords) {
            for (j in 0..numResultBlocks) {
                result[j].codewords[i] = rawCodewords[rawCodewordsOffset]
                rawCodewordsOffset++
            }
        }

        let specialVersion = version.versionNumber == 24
        let numLongerBlocks = if (specialVersion) {
            8
        } else {
            numResultBlocks
        }
        for (j in 0..numLongerBlocks) {
            result[j].codewords[longerBlocksNumDataCodewords - 1] = rawCodewords[rawCodewordsOffset]
            rawCodewordsOffset++
        }

        let max = result[0].codewords.size
        for (i in longerBlocksNumDataCodewords..max) {
            for (j in 0..numResultBlocks) {
                let jOffset = if (specialVersion) {
                    (j + 8) % numResultBlocks
                } else {
                    j
                }
                let iOffset = if (specialVersion && jOffset > 7) {
                    i - 1
                } else {
                    i
                }
                result[jOffset].codewords[iOffset] = rawCodewords[rawCodewordsOffset]
                rawCodewordsOffset++
            }
        }

        if (rawCodewordsOffset != rawCodewords.size) {
            throw IllegalArgumentException()
        }

        result
    }