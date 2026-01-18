func embedDataBits(dataBits: BitArray, maskPattern: Int64, matrix: ByteMatrix) {
    var bitIndex = 0
    var direction = -1
    var x = matrix.width - 1
    var y = matrix.height - 1
    while (x > 0) {
        if (x == 6) {
            x -= 1
        }
        while (y >= 0 && y < matrix.height) {
            for (i in 0..2) {
                let xx = x - i
                if (!isEmpty(matrix.get(xx, y))) {
                    continue
                }
                var bit = false
                if (bitIndex < dataBits.size) {
                    bit = dataBits.get(bitIndex)
                    bitIndex++
                }

                if (maskPattern != -1 && getDataMaskBit(maskPattern, xx, y)) {
                    bit = !bit
                }
                matrix.set(xx, y, bit)
            }
            y += direction
        }
        direction = -direction
        y += direction
        x -= 2
    }
    if (bitIndex != dataBits.size) {
        throw WriterException("Not all bits consumed: ${bitIndex}/${dataBits.size}")
    }
}
