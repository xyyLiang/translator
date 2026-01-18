    static func encodeLowLevel(placement: DefaultPlacement, symbolInfo: SymbolInfo, width: Int64, height: Int64): BitMatrix {
        let symbolWidth = symbolInfo.getSymbolDataWidth()
        let symbolHeight = symbolInfo.getSymbolDataHeight()

        let matrix = ByteMatrix(symbolInfo.getSymbolWidth(), symbolInfo.getSymbolHeight())

        var matrixY = 0
        for (y in 0..symbolHeight) {
            var matrixX = 0
            if ((y % symbolInfo.matrixHeight) == 0) {
                matrixX = 0
                for (x in 0..symbolInfo.getSymbolWidth()) {
                    matrix.set(matrixX, matrixY, (x % 2) == 0)
                    matrixX++
                }
                matrixY++
            }
            matrixX = 0
            for (x in 0..symbolWidth) {
                if ((x % symbolInfo.matrixWidth) == 0) {
                    matrix.set(matrixX, matrixY, true)
                    matrixX++
                }
                matrix.set(matrixX, matrixY, placement.getBit(x, y))
                matrixX++

                if ((x % symbolInfo.matrixWidth) == symbolInfo.matrixWidth - 1) {
                    matrix.set(matrixX, matrixY, (y % 2) == 0)
                    matrixX++
                }
            }
            matrixY++

            if ((y % symbolInfo.matrixHeight) == symbolInfo.matrixHeight - 1) {
                matrixX = 0
                for (x in 0..symbolInfo.getSymbolWidth()) {
                    matrix.set(matrixX, matrixY, true)
                    matrixX++
                }
                matrixY++
            }
        }
        convertByteMatrixToBitMatrix(matrix, width, height)
    }