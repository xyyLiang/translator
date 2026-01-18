    static func bitMatrixFromBitArray(input: Array<Array<UInt8>>, margin: Int64): BitMatrix {
        let width = input[0].size
        let output = BitMatrix(width + 2 * margin, input.size + 2 * margin)
        output.clear()
        var yOutput = output.height - margin - 1
        for (y in 0..input.size) {
            let inputY = input[y]
            for (x in 0..width) {
                if (inputY[x] == 1) {
                    output.set(x + margin, yOutput)
                }
            }
            yOutput--
        }
        output
    }