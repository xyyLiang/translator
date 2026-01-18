    static func encode(data: Array<UInt8>, minECCPercent: Int64, userSpecifiedLayers: Int64): AztecCode {
        let bits = HighLevelEncoder(data).encode()

        let eccBits = bits.size * minECCPercent / 100 + 11
        let totalSizeBits = bits.size + eccBits
        var compact = false
        var layers = 0
        var totalBitsInLayer = 0
        var wordSize = 0
        var stuffedBits: ?BitArray = None
        if (userSpecifiedLayers != DEFAULT_AZTEC_LAYERS) {
            compact = userSpecifiedLayers < 0
            layers = math.abs(userSpecifiedLayers)
            if (layers > (if (compact) {
                MAX_NB_BITS_COMPACT
            } else {
                MAX_NB_BITS
            })) {
                throw IllegalArgumentException("Illegal value ${userSpecifiedLayers} for layers")
            }
            totalBitsInLayer = getTotalBitsInLayer(layers, compact)
            wordSize = WORD_SIZE[layers]
            let usableBitsInLayers = totalBitsInLayer - (totalBitsInLayer % wordSize)
            stuffedBits = stuffBits(bits, wordSize)
            if (stuffedBits.getOrThrow().size + eccBits > usableBitsInLayers) {
                throw IllegalArgumentException("Data to large for user specified layer")
            }
            if (compact && stuffedBits.getOrThrow().size > wordSize * 64) {
                throw IllegalArgumentException("Data to large for user specified layer")
            }
        } else {
            wordSize = 0
            stuffedBits = None
            var i = 0
            while (true) {
                if (i > MAX_NB_BITS) {
                    throw IllegalArgumentException("Data too large for an Aztec code")
                }
                compact = i <= 3
                layers = if (compact) {
                    i + 1
                } else {
                    i
                }
                totalBitsInLayer = getTotalBitsInLayer(layers, compact)
                if (totalSizeBits > totalBitsInLayer) {
                    continue
                }
                if (let None = stuffedBits) {
                    wordSize = WORD_SIZE[layers]
                    stuffedBits = stuffBits(bits, wordSize)
                } else if (wordSize != WORD_SIZE[layers]) {
                    wordSize = WORD_SIZE[layers]
                    stuffedBits = stuffBits(bits, wordSize)
                }
                let usableBitsInLayers = totalBitsInLayer - (totalBitsInLayer % wordSize)
                if (compact && stuffedBits.getOrThrow().size > wordSize * 64) {
                    continue
                }
                if (stuffedBits.getOrThrow().size + eccBits <= usableBitsInLayers) {
                    break
                }
                i++
            }
        }

        let messageBits = generateCheckWords(stuffedBits.getOrThrow(), totalBitsInLayer, wordSize)

        let messageSizeInWords = stuffedBits.getOrThrow().size / wordSize
        let modeMessage = generateModeMessage(compact, layers, messageSizeInWords)

        let baseMatrixSize = (if (compact) {
            11
        } else {
            14
        }) + layers * 4
        let alignmentMap = Array<Int64>(baseMatrixSize, item: 0)
        let matrixSize = if (compact) {
            for (i in 0..alignmentMap.size) {
                alignmentMap[i] = i
            }
            baseMatrixSize
        } else {
            let ms = baseMatrixSize + 1 + 2 * ((baseMatrixSize / 2 - 1) / 15)
            let origCenter = baseMatrixSize / 2
            let center = ms / 2
            for (i in 0..origCenter) {
                let newOffset = i + i / 15
                alignmentMap[origCenter - i - 1] = center - newOffset - 1
                alignmentMap[origCenter + i] = center + newOffset + 1
            }
            ms
        }
        let matrix = BitMatrix(matrixSize)

        var rowOffset = 0
        for (i in 0..layers) {
            let rowSize = (layers - i) * 4 + (if (compact) {
                9
            } else {
                12
            })
            for (j in 0..rowSize) {
                let columnOffset = j * 2
                for (k in 0..2) {
                    if (messageBits.get(rowOffset + columnOffset + k)) {
                        matrix.set(alignmentMap[i * 2 + k], alignmentMap[i * 2 + j])
                    }
                    if (messageBits.get(rowOffset + rowSize * 2 + columnOffset + k)) {
                        matrix.set(alignmentMap[i * 2 + j], alignmentMap[baseMatrixSize - 1 - i * 2 - k])
                    }
                    if (messageBits.get(rowOffset + rowSize * 4 + columnOffset + k)) {
                        matrix.set(
                            alignmentMap[baseMatrixSize - 1 - i * 2 - k],
                            alignmentMap[baseMatrixSize - 1 - i * 2 - j]
                        )
                    }
                    if (messageBits.get(rowOffset + rowSize * 6 + columnOffset + k)) {
                        matrix.set(alignmentMap[baseMatrixSize - 1 - i * 2 - j], alignmentMap[i * 2 + k])
                    }
                }
            }
            rowOffset += rowSize * 8
        }

        drawModeMessage(matrix, compact, matrixSize, modeMessage)

        if (compact) {
            drawBullsEye(matrix, matrixSize / 2, 5)
        } else {
            drawBullsEye(matrix, matrixSize / 2, 7)
            var i = 0
            var j = 0
            while (i < baseMatrixSize / 2 - 1) {
                for (k in ((matrixSize / 2) & 1)..matrixSize : 2) {
                    matrix.set(matrixSize / 2 - j, k)
                    matrix.set(matrixSize / 2 + j, k)
                    matrix.set(k, matrixSize / 2 - j)
                    matrix.set(k, matrixSize / 2 + j)
                }
                i += 15
                j += 16
            }
        }

        let aztec = AztecCode()
        aztec.compact = compact
        aztec.size = matrixSize
        aztec.layers = layers
        aztec.codeWords = messageSizeInWords
        aztec.matrix = matrix
        aztec
    }