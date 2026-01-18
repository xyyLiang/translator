    static func renderResult(code: AztecCode, width: Int64, height: Int64): BitMatrix {
        if (let Some(input) = code.matrix) {
            let inputWidth = input.width
            let inputHeight = input.height
            let outputWidth = math.max(width, inputWidth)
            let outputHeight = math.max(height, inputHeight)

            let multiple = math.min(outputWidth / inputWidth, outputHeight / inputHeight)
            let leftPadding = (outputWidth - (inputWidth * multiple)) / 2
            let topPadding = (outputHeight - (inputHeight * multiple)) / 2

            let output = BitMatrix(outputWidth, outputHeight)
            var outputY = topPadding
            for (inputY in 0..inputHeight) {
                var outputX = leftPadding
                for (inputX in 0..inputWidth) {
                    if (input.get(inputX, inputY)) {
                        output.setRegion(outputX, outputY, multiple, multiple)
                    }
                    outputX += multiple
                }
                outputY += multiple
            }
            return output
        }
        throw Exception("IllegalStateException")
    }