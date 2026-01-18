    func extractBits(matrix: BitMatrix): Array<Bool> {
        let compact = ddata.compact
        let layers = ddata.nbLayers
        let baseMatrixSize = (if (compact) {
            11
        } else {
            14
        }) + layers * 4
        let alignmentMap = Array<Int64>(baseMatrixSize, item: 0)
        let rawbits = Array<Bool>(totalBitsInLayer(layers, compact), item: false)

        if (compact) {
            for (i in 0..alignmentMap.size) {
                alignmentMap[i] = i
            }
        } else {
            let matrixSize = baseMatrixSize + 1 + 2 * ((baseMatrixSize / 2 - 1) / 15)
            let origCenter = baseMatrixSize / 2
            let center = matrixSize / 2
            for (i in 0..origCenter) {
                let newOffset = i + i / 15
                alignmentMap[origCenter - i - 1] = center - newOffset - 1
                alignmentMap[origCenter + i] = center + newOffset + 1
            }
        }
        var rowOffset = 0
        for (i in 0..layers) {
            let rowSize = (layers - i) * 4 + (if (compact) {
                9
            } else {
                12
            })
            let low = i * 2
            let high = baseMatrixSize - 1 - low
            for (j in 0..rowSize) {
                let columnOffset = j * 2
                for (k in 0..2) {
                    rawbits[rowOffset + columnOffset + k] = matrix.get(alignmentMap[low + k], alignmentMap[low + j])
                    rawbits[rowOffset + 2 * rowSize + columnOffset + k] = matrix.get(
                        alignmentMap[low + j],
                        alignmentMap[high - k]
                    )
                    rawbits[rowOffset + 4 * rowSize + columnOffset + k] = matrix.get(
                        alignmentMap[high - k],
                        alignmentMap[high - j]
                    )
                    rawbits[rowOffset + 6 * rowSize + columnOffset + k] = matrix.get(
                        alignmentMap[high - j],
                        alignmentMap[low + k]
                    )
                }
            }
            rowOffset += rowSize * 8
        }
        rawbits
    }
