    static func getModuleBitCount(
        image: BitMatrix,
        minColumn: Int64,
        maxColumn: Int64,
        leftToRight: Bool,
        startColumn: Int64,
        imageRow: Int64
    ): ?Array<Int64> {
        var imageColumn = startColumn
        let moduleBitCount = Array<Int64>(8, item: 0)
        var moduleNumber = 0
        let increment = if (leftToRight) {
            1
        } else {
            -1
        }
        var previousPixelValue = leftToRight
        while ((if (leftToRight) {
                imageColumn < maxColumn
            } else {
                imageColumn >= minColumn
            }) && moduleNumber < moduleBitCount.size) {
            if (image.get(imageColumn, imageRow) == previousPixelValue) {
                moduleBitCount[moduleNumber] += 1
                imageColumn += increment
            } else {
                moduleNumber++
                previousPixelValue = !previousPixelValue
            }
        }
        if (moduleNumber == moduleBitCount.size || ((imageColumn == (if (leftToRight) {
            maxColumn
        } else {
            minColumn
        })) && moduleNumber == moduleBitCount.size - 1)) {
            moduleBitCount
        } else {
            None
        }
    }