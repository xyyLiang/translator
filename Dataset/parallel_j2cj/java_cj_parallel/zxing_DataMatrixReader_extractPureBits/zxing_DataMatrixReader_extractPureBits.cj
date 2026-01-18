    static func extractPureBits(image: BitMatrix): BitMatrix {
        let leftTopBlack = image.getTopLeftOnBit()
        let rightBottomBlack = image.getBottomRightOnBit()
        if (let (Some(leftTopBlack), Some(rightBottomBlack)) = (image.getTopLeftOnBit(), image.getBottomRightOnBit())) {
            let moduleSize = moduleSize(leftTopBlack, image)

            var top = leftTopBlack[1]
            let bottom = rightBottomBlack[1]
            var left = leftTopBlack[0]
            let right = rightBottomBlack[0]

            let matrixWidth = (right - left + 1) / moduleSize
            let matrixHeight = (bottom - top + 1) / moduleSize
            if (matrixWidth <= 0 || matrixHeight <= 0) {
                throw NotFoundException()
            }

            let nudge = moduleSize / 2
            top += nudge
            left += nudge

            let bits = BitMatrix(matrixWidth, matrixHeight)
            for (y in 0..matrixHeight) {
                let iOffset = top + y * moduleSize
                for (x in 0..matrixWidth) {
                    if (image.get(left + x * moduleSize, iOffset)) {
                        bits.set(x, y)
                    }
                }
            }
            bits
        }
        throw NotFoundException()
    }