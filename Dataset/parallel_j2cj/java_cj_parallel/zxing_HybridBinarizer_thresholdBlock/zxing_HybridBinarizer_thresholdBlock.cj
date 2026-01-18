    static func thresholdBlock(
        luminances: Array<UInt8>,
        xoffset: Int64,
        yoffset: Int64,
        threshold: Int64,
        stride: Int64,
        matrix: BitMatrix
    ) {
        var offset = yoffset * stride + xoffset
        for (y in 0..BLOCK_SIZE) {
            for (x in 0..BLOCK_SIZE) {
                if (Int64(luminances[offset + x] & 0xFF) <= threshold) {
                    matrix.set(xoffset + x, yoffset + y)
                }
            }
            offset += stride
        }
    }
