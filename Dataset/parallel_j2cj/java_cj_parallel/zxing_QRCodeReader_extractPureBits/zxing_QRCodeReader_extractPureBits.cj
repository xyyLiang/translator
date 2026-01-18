func extractPureBits(image: BitMatrix): BitMatrix {
    let leftTopBlack = if (let Some(d) = image.getTopLeftOnBit()) {
        d
    } else {
        throw NotFoundException()
    }
    let rightBottomBlack = if (let Some(d) = image.getBottomRightOnBit()) {
        d
    } else {
        throw NotFoundException()
    }

    let mSize = moduleSize(leftTopBlack, image)

    var top = leftTopBlack[1]
    var bottom = rightBottomBlack[1]
    var left = leftTopBlack[0]
    var right = rightBottomBlack[0]

    if (left >= right || top >= bottom) {
        throw NotFoundException()
    }

    if (bottom - top != right - left) {
        right = left + (bottom - top)
        if (right >= image.width) {
            throw NotFoundException()
        }
    }

    let matrixWidth = math.round(Float64(right - left + 1) / mSize)
    let matrixHeight = math.round(Float64(bottom - top + 1) / mSize)
    if (matrixWidth <= 0.0 || matrixHeight <= 0.0) {
        throw NotFoundException()
    }
    if (matrixHeight != matrixWidth) {
        throw NotFoundException()
    }

    let nudge = Int64(mSize / 2.0)
    top += nudge
    left += nudge

    let nudgedTooFarRight = left + Int64((matrixWidth - 1.0) * mSize) - right
    if (nudgedTooFarRight > 0) {
        if (nudgedTooFarRight > nudge) {
            throw NotFoundException()
        }
        left -= nudgedTooFarRight
    }

    let nudgedTooFarDown = top + Int64((matrixHeight - 1.0) * mSize) - bottom
    if (nudgedTooFarDown > 0) {
        if (nudgedTooFarDown > nudge) {
            throw NotFoundException()
        }
        top -= nudgedTooFarDown
    }

    let bits = BitMatrix(Int64(matrixWidth), Int64(matrixHeight))
    for (y in 0..Int64(matrixHeight)) {
        let iOffset = top + Int64(Float64(y) * mSize)
        for (x in 0..Int64(matrixWidth)) {
            if (image.get(left + Int64(Float64(x) * mSize), iOffset)) {
                bits.set(x, y)
            }
        }
    }
    bits
}