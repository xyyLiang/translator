    static func renderResult(code: QRCode, width: Int64, height: Int64, quietZone: Int64): BitMatrix {
        if (let Some(input) = code.matrix) {
            let inputWidth = input.width
            let inputHeight = input.height
            let qrWidth = inputWidth + (quietZone * 2)
            let qrHeight = inputHeight + (quietZone * 2)
            let outputWidth = math.max(width, qrWidth)
            let outputHeight = math.max(height, qrHeight)

            let multiple = math.min(outputWidth / qrWidth, outputHeight / qrHeight)
            let leftPadding = (outputWidth - (inputWidth * multiple)) / 2
            let topPadding = (outputHeight - (inputHeight * multiple)) / 2

            let output = BitMatrix(outputWidth, outputHeight)
            var outputY = topPadding
            for (inputY in 0..inputHeight) {
                var outputX = leftPadding
                for (inputX in 0..inputWidth) {
                    if (input.get(inputX, inputY) == 1) {
                        output.setRegion(outputX, outputY, multiple, multiple)
                    }
                    outputX += multiple
                }
                outputY += multiple
            }
            output
        } else {
            throw Exception("IllegalStateException")
        }
    }