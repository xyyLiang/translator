func getDataBlocks(
    rawCodewords: Array<UInt8>,
    version: Version,
    ecLevel: ErrorCorrectionLevel
): Array<DataBlock> {
    if (rawCodewords.size != version.totalCodewords) {
        throw IllegalArgumentException()
    }

    let ecBlocks = version.ecBlocksForLevel(ecLevel)

    var totalBlocks = 0
    let ecBlockArray = ecBlocks.ecBlocks
    for (ecBlock in ecBlockArray) {
        totalBlocks += ecBlock.count
    }

    let result = Array<DataBlock>(totalBlocks, item: DataBlock(0, []))
    var numResultBlocks = 0
    for (ecBlock in ecBlockArray) {
        for (i in 0..ecBlock.count) {
            let numDataCodewords = ecBlock.dataCodewords
            let numBlockCodewords = ecBlocks.ecCodewordsPerBlock + numDataCodewords
            result[numResultBlocks] = DataBlock(numDataCodewords, Array<UInt8>(numBlockCodewords, item: 0))
            numResultBlocks++
        }
    }

    let shorterBlocksTotalCodewords = result[0].codewords.size
    var longerBlocksStartAt = result.size - 1
    while (longerBlocksStartAt >= 0) {
        let numCodewords = result[longerBlocksStartAt].codewords.size
        if (numCodewords == shorterBlocksTotalCodewords) {
            break
        }
        longerBlocksStartAt--
    }
    longerBlocksStartAt++

    let shorterBlocksNumDataCodewords = shorterBlocksTotalCodewords - ecBlocks.ecCodewordsPerBlock
    var rawCodewordsOffset = 0
    for (i in 0..shorterBlocksNumDataCodewords) {
        for (j in 0..numResultBlocks) {
            result[j].codewords[i] = rawCodewords[rawCodewordsOffset]
            rawCodewordsOffset++
        }
    }
    for (j in longerBlocksStartAt..numResultBlocks) {
        result[j].codewords[shorterBlocksNumDataCodewords] = rawCodewords[rawCodewordsOffset]
        rawCodewordsOffset++
    }
    for (i in shorterBlocksNumDataCodewords..result[0].codewords.size) {
        for (j in 0..numResultBlocks) {
            let iOffset = if (j < longerBlocksStartAt) {
                i
            } else {
                i + 1
            }
            result[j].codewords[iOffset] = rawCodewords[rawCodewordsOffset]
            rawCodewordsOffset++
        }
    }
    result
}