    func buildFunctionPattern(): BitMatrix {
        let dimension = dimensionForVersion()
        let bitMatrix = BitMatrix(dimension)

        bitMatrix.setRegion(0, 0, 9, 9)
        bitMatrix.setRegion(dimension - 8, 0, 8, 9)
        bitMatrix.setRegion(0, dimension - 8, 9, 8)

        let max = alignmentPatternCenters.size
        for (x in 0..max) {
            let i = alignmentPatternCenters[x] - 2
            for (y in 0..max) {
                if ((x != 0 || (y != 0 && y != max - 1)) && (x != max - 1 || y != 0)) {
                    bitMatrix.setRegion(alignmentPatternCenters[y] - 2, i, 5, 5)
                }
            }
        }

        bitMatrix.setRegion(6, 9, 1, dimension - 17)
        bitMatrix.setRegion(9, 6, dimension - 17, 1)

        if (versionNumber > 6) {
            bitMatrix.setRegion(dimension - 11, 0, 3, 6)
            bitMatrix.setRegion(0, dimension - 11, 6, 3)
        }

        bitMatrix
    }