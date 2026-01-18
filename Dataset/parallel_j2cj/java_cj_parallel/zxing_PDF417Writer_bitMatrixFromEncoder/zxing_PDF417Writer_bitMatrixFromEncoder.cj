    static func bitMatrixFromEncoder(
        encoder: PDF417,
        contents: String,
        errorCorrectionLevel: Int64,
        width: Int64,
        height: Int64,
        margin: Int64,
        autoECI: Bool
    ): BitMatrix {
        encoder.generateBarcodeLogic(contents, errorCorrectionLevel, autoECI)
        var aspectRatio = 4
        var originalScale = encoder.barcodeMatrix.getOrThrow().getScaledMatrix(1, aspectRatio)
        var rotated = false
        if ((height > width) != (originalScale[0].size < originalScale.size)) {
            originalScale = rotateArray(originalScale)
            rotated = true
        }
        let scaleX = width / originalScale[0].size
        let scaleY = height / originalScale.size
        let scale = math.min(scaleX, scaleY)

        if (scale > 1) {
            var scaledMatrix = encoder.barcodeMatrix.getOrThrow().getScaledMatrix(scale, scale * aspectRatio)
            if (rotated) {
                scaledMatrix = rotateArray(scaledMatrix)
            }
            bitMatrixFromBitArray(scaledMatrix, margin)
        } else {
            bitMatrixFromBitArray(originalScale, margin)
        }
    }