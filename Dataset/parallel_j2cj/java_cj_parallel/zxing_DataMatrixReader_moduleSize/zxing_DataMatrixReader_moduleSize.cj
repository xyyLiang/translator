    static func moduleSize(leftTopBlack: Array<Int64>, image: BitMatrix): Int64 {
        let width = image.width
        var x = leftTopBlack[0]
        var y = leftTopBlack[1]
        while (x < width && image.get(x, y)) {
            x++
        }
        if (x == width) {
            throw NotFoundException()
        }

        let moduleSize = x - leftTopBlack[0]
        if (moduleSize == 0) {
            throw NotFoundException()
        }
        moduleSize
    }