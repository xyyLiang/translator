    static func interleaveWithECBytes(
        bits: BitArray,
        numTotalBytes: Int64,
        numDataBytes: Int64,
        numRSBlocks: Int64
    ): BitArray {
        if (bits.sizeInBytes() != numDataBytes) {
            throw WriterException("Number of bits and data bytes does not match")
        }

        var dataBytesOffset = 0
        var maxNumDataBytes = 0
        var maxNumEcBytes = 0

        let blocks = ArrayList<BlockPair>(numRSBlocks)

        for (i in 0..numRSBlocks) {
            let numDataBytesInBlock = [0]
            let numEcBytesInBlock = [0]
            getNumDataBytesAndNumECBytesForBlockID(
                numTotalBytes,
                numDataBytes,
                numRSBlocks,
                i,
                numDataBytesInBlock,
                numEcBytesInBlock
            )

            let size = numDataBytesInBlock[0]
            let dataBytes = Array<Int8>(size, item: 0)
            bits.toBytes(8 * dataBytesOffset, dataBytes, 0, size)
            let ecBytes = generateECBytes(dataBytes, numEcBytesInBlock[0])
            blocks.append(BlockPair(dataBytes, ecBytes))

            maxNumDataBytes = math.max(maxNumDataBytes, size)
            maxNumEcBytes = math.max(maxNumEcBytes, ecBytes.size)
            dataBytesOffset += numDataBytesInBlock[0]
        }
        if (numDataBytes != dataBytesOffset) {
            throw WriterException("Data bytes does not match offset")
        }

        let result = BitArray()
        for (i in 0..maxNumDataBytes) {
            for (block in blocks) {
                let dataBytes = block.dataBytes
                if (i < dataBytes.size) {
                    result.appendBits(Int64(dataBytes[i]), 8)
                }
            }
        }
        for (i in 0..maxNumEcBytes) {
            for (block in blocks) {
                let ecBytes = block.errorCorrectionBytes
                if (i < ecBytes.size) {
                    result.appendBits(Int64(ecBytes[i]), 8)
                }
            }
        }
        if (numTotalBytes != result.sizeInBytes()) {
            throw WriterException("Interleaving error: ${numTotalBytes} and ${result.sizeInBytes()} differ.")
        }
        result
    }