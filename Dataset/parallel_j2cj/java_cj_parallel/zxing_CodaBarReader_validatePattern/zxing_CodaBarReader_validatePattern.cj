    func validatePattern(start: Int64) {
        let sizes = [0, 0, 0, 0]
        let counts = [0, 0, 0, 0]
        let end = decodeRowResult.size - 1

        var pos = start
        for (i in 0..=end) {
            var pattern = CHARACTER_ENCODINGS[Int64(UInt32(decodeRowResult.get(i).getOrThrow()))]
            for (j in 6..=0 : -1) {
                let category = (j & 1) + (pattern & 1) * 2
                sizes[category] += counters[pos + j]
                counts[category] += 1
                pattern >>= 1
            }
            pos += 8
        }

        let maxes = Array<Float64>(4, item: 0.0)
        let mins = Array<Float64>(4, item: 0.0)
        for (i in 0..2) {
            mins[i] = 0.0
            mins[i + 2] = (Float64(sizes[i]) / Float64(counts[i]) + Float64(sizes[i + 2]) / Float64(counts[i + 2])) / 2.0
            maxes[i] = mins[i + 2]
            maxes[i + 2] = (Float64(sizes[i + 2]) * MAX_ACCEPTABLE + PADDING) / Float64(counts[i + 2])
        }

        pos = start
        for (i in 0..=end) {
            var pattern = CHARACTER_ENCODINGS[Int64(UInt32(decodeRowResult.get(i).getOrThrow()))]
            for (j in 6..=0 : -1) {
                let category = (j & 1) + (pattern & 1) * 2
                let size = Float64(counters[pos + j])
                if (size < mins[category] || size > maxes[category]) {
                    throw NotFoundException()
                }
                pattern >>= 1
            }
            pos += 8
        }
    }
