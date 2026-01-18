    static func calculateThresholdForBlock(
        luminances: Array<UInt8>,
        subWidth: Int64,
        subHeight: Int64,
        width: Int64,
        height: Int64,
        blackPoints: Array<Array<Int64>>,
        matrix: BitMatrix
    ) {
        let maxYOffset = height - BLOCK_SIZE
        let maxXOffset = width - BLOCK_SIZE
        for (y in 0..subHeight) {
            var yoffset = y << BLOCK_SIZE_POWER
            if (yoffset > maxYOffset) {
                yoffset = maxYOffset
            }
            let top = cap(y, subHeight - 3)
            for (x in 0..subWidth) {
                var xoffset = x << BLOCK_SIZE_POWER
                if (xoffset > maxXOffset) {
                    xoffset = maxXOffset
                }
                let left = cap(x, subWidth - 3)
                var sum = 0
                for (z in -2..2) {
                    let blackRow = blackPoints[top + z]
                    sum += blackRow[left - 2] + blackRow[left - 1] + blackRow[left] + blackRow[left + 1] + blackRow[left+
                            2]
                }
                let average = sum / 25
                thresholdBlock(luminances, xoffset, yoffset, average, width, matrix)
            }
        }
    }