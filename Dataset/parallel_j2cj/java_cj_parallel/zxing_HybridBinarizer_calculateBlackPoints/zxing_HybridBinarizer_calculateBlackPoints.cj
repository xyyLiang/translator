    static func calculateBlackPoints(
        luminances: Array<UInt8>,
        subWidth: Int64,
        subHeight: Int64,
        width: Int64,
        height: Int64
    ): Array<Array<Int64>> {
        let maxYOffset = height - BLOCK_SIZE
        let maxXOffset = width - BLOCK_SIZE
        let blackPoints = Array<Array<Int64>>(subHeight, {n => Array<Int64>(subWidth, item: 0)})
        for (y in 0..subHeight) {
            var yoffset = y << BLOCK_SIZE_POWER
            if (yoffset > maxYOffset) {
                yoffset = maxYOffset
            }
            for (x in 0..subWidth) {
                var xoffset = x << BLOCK_SIZE_POWER
                if (xoffset > maxXOffset) {
                    xoffset = maxXOffset
                }
                var sum = 0
                var min = 0xFF
                var max = 0
                var offset = yoffset * width + xoffset
                var yy = 0
                while (yy < BLOCK_SIZE) {
                    for (xx in 0..BLOCK_SIZE) {
                        let pixel = Int64(luminances[offset + xx] & 0xFF)
                        sum += pixel

                        if (pixel < min) {
                            min = pixel
                        }
                        if (pixel > max) {
                            max = pixel
                        }
                    }
                    if (max - min > MIN_DYNAMIC_RANGE) {
                        yy++
                        offset += width
                        while (yy < BLOCK_SIZE) {
                            for (xx in 0..BLOCK_SIZE) {
                                sum += Int64(luminances[offset + xx] & 0xFF)
                            }
                            yy++
                            offset += width
                        }
                    }
                    yy++
                    offset += width
                }

                var average = sum >> (BLOCK_SIZE_POWER * 2)
                if (max - min <= MIN_DYNAMIC_RANGE) {
                    average = min / 2

                    if (y > 0 && x > 0) {
                        let averageNeighborBlackPoint = 
                            (blackPoints[y - 1][x] + (2 * blackPoints[y][x - 1]) + blackPoints[y - 1][x - 1]) / 4
                        if (min < averageNeighborBlackPoint) {
                            average = averageNeighborBlackPoint
                        }
                    }
                }
                blackPoints[y][x] = average
            }
        }
        blackPoints
    }