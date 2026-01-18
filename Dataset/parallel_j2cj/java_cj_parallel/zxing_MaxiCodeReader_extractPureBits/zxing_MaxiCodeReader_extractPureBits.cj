    static func extractPureBits(image: BitMatrix): BitMatrix {
        let enclosingRectangle = image.getEnclosingRectangle()
        if (let Some(enclosingRectangle) = image.getEnclosingRectangle()) {
            let left = enclosingRectangle[0]
            let top = enclosingRectangle[1]
            let width = enclosingRectangle[2]
            let height = enclosingRectangle[3]
            let bits = BitMatrix(MATRIX_WIDTH, MATRIX_HEIGHT)
            for (y in 0..MATRIX_HEIGHT) {
                let iy = math.min(top + (y * height + height / 2) / MATRIX_HEIGHT, height - 1)
                for (x in 0..MATRIX_WIDTH) {
                    let ix = left + math.min(
                        (x * width + width / 2 + (y & 0x01) * width / 2) / MATRIX_WIDTH,
                        width - 1
                    )
                    if (image.get(ix, iy)) {
                        bits.set(x, y)
                    }
                }
            }
            bits
        } else {
            throw NotFoundException()
        }
    }
