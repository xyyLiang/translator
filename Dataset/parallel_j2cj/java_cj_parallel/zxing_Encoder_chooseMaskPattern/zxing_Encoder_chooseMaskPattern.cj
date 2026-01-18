    static func chooseMaskPattern(
        bits: BitArray,
        ecLevel: ErrorCorrectionLevel,
        version: Version,
        matrix: ByteMatrix
    ): Int64 {
        var minPenalty = Int64.Max
        var bestMaskPattern = -1
        for (maskPattern in 0..QRCode.NUM_MASK_PATTERNS) {
            buildMatrix(bits, ecLevel, version, maskPattern, matrix)
            let penalty = calculateMaskPenalty(matrix)
            if (penalty < minPenalty) {
                minPenalty = penalty
                bestMaskPattern = maskPattern
            }
        }
        bestMaskPattern
    }