    static func findGuardPattern(
        matrix: BitMatrix,
        column: Int64,
        row: Int64,
        width: Int64,
        pattern: Array<Int64>,
        counters: Array<Int64>
    ): ?Array<Int64> {
        for (i in 0..counters.size) {
            counters[i] = 0
        }

        var patternStart = column
        var pixelDrift = 0

        func addPixelDrift(): Bool {
            pixelDrift++
            true
        }

        while (matrix.get(patternStart, row) && patternStart > 0 && pixelDrift < MAX_PIXEL_DRIFT && addPixelDrift()) {
            patternStart--
        }
        var x = patternStart
        var counterPosition = 0
        var patternLength = pattern.size
        var isWhite = false
        while (x < width) {
            let pixel = matrix.get(x, row)
            if (pixel != isWhite) {
                counters[counterPosition] += 1
            } else {
                if (counterPosition == patternLength - 1) {
                    if (patternMatchVariance(counters, pattern) < MAX_AVG_VARIANCE) {
                        return [patternStart, x]
                    }
                    patternStart += counters[0] + counters[1]
                    counters.copyTo(counters, 2, 0, counterPosition - 1)
                    counters[counterPosition - 1] = 0
                    counters[counterPosition] = 0
                    counterPosition--
                } else {
                    counterPosition++
                }
                counters[counterPosition] = 1
                isWhite = !isWhite
            }
            x++
        }
        if (counterPosition == patternLength - 1 && patternMatchVariance(counters, pattern) < MAX_AVG_VARIANCE) {
            [patternStart, x - 1]
        } else {
            None
        }
    }