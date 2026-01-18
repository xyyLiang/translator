    static func renderResult(code: Array<Bool>, width: Int64, height: Int64, sidesMargin: Int64): BitMatrix {
        let inputWidth = code.size
        let fullWidth = inputWidth + sidesMargin
        let outputWidth = math.max(width, fullWidth)
        let outputHeight = math.max(1, height)

        let multiple = outputWidth / fullWidth
        let leftPadding = (outputWidth - (inputWidth * multiple)) / 2

        let output = BitMatrix(outputWidth, outputHeight)
        var outputX = leftPadding
        for (inputX in 0..inputWidth) {
            if (code[inputX]) {
                output.setRegion(outputX, 0, multiple, outputHeight)
            }
            outputX += multiple
        }
        output
    }