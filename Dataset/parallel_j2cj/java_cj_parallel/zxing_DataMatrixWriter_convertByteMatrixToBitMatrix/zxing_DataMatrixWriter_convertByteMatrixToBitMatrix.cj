    static func convertByteMatrixToBitMatrix(matrix: ByteMatrix, reqWidth: Int64, reqHeight: Int64): BitMatrix {
        let matrixWidth = matrix.width
        let matrixHeight = matrix.height
        let outputWidth = math.max(reqWidth, matrixWidth)
        let outputHeight = math.max(reqHeight, matrixHeight)

        let multiple = math.min(outputWidth / matrixWidth, outputHeight / matrixHeight)

        var leftPadding = (outputWidth - (matrixWidth * multiple)) / 2
        var topPadding = (outputHeight - (matrixHeight * multiple)) / 2

        let output = if (reqHeight < matrixHeight || reqWidth < matrixWidth) {
            leftPadding = 0
            topPadding = 0
            BitMatrix(matrixWidth, matrixHeight)
        } else {
            BitMatrix(reqWidth, reqHeight)
        }

        output.clear()
        var outputY = topPadding
        for (inputY in 0..matrixHeight) {
            var outputX = leftPadding
            for (inputX in 0..matrixWidth) {
                if (matrix.get(inputX, inputY) == 1) {
                    output.setRegion(outputX, outputY, multiple, multiple)
                }
                outputX += multiple
            }
            outputY += multiple
        }
        output
    }