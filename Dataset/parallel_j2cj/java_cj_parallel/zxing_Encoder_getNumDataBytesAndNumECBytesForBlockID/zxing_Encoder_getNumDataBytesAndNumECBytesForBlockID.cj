    static func getNumDataBytesAndNumECBytesForBlockID(
        numTotalBytes: Int64,
        numDataBytes: Int64,
        numRSBlocks: Int64,
        blockID: Int64,
        numDataBytesInBlock: Array<Int64>,
        numECBytesInBlock: Array<Int64>
    ) {
        if (blockID >= numRSBlocks) {
            throw WriterException("Block ID too large")
        }
        let numRsBlocksInGroup2 = numTotalBytes % numRSBlocks
        let numRsBlocksInGroup1 = numRSBlocks - numRsBlocksInGroup2
        let numTotalBytesInGroup1 = numTotalBytes / numRSBlocks
        let numTotalBytesInGroup2 = numTotalBytesInGroup1 + 1
        let numDataBytesInGroup1 = numDataBytes / numRSBlocks
        let numDataBytesInGroup2 = numDataBytesInGroup1 + 1
        let numEcBytesInGroup1 = numTotalBytesInGroup1 - numDataBytesInGroup1
        let numEcBytesInGroup2 = numTotalBytesInGroup2 - numDataBytesInGroup2
        if (numEcBytesInGroup1 != numEcBytesInGroup2) {
            throw WriterException("EC bytes mismatch")
        }
        if (numRSBlocks != numRsBlocksInGroup1 + numRsBlocksInGroup2) {
            throw WriterException("RS blocks mismatch")
        }
        if (numTotalBytes != ((numDataBytesInGroup1 + numEcBytesInGroup1) * numRsBlocksInGroup1) + ((numDataBytesInGroup2+
            numEcBytesInGroup2) * numRsBlocksInGroup2)) {
            throw WriterException("Total bytes mismatch")
        }

        if (blockID < numRsBlocksInGroup1) {
            numDataBytesInBlock[0] = numDataBytesInGroup1
            numECBytesInBlock[0] = numEcBytesInGroup1
        } else {
            numDataBytesInBlock[0] = numDataBytesInGroup2
            numECBytesInBlock[0] = numEcBytesInGroup2
        }
    }