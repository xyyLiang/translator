    static func toPattern(counters: Array<Int64>): Int64 {
        var sum = 0
        for (counter in counters) {
            sum += counter
        }
        var pattern = 0
        for (i in 0..counters.size) {
            let scaled = Int64(math.round(Float64(counters[i]) * 9.0 / Float64(sum)))
            if (scaled < 1 || scaled > 4) {
                return -1
            }
            if ((i & 0x01) == 0) {
                for (j in 0..scaled) {
                    pattern = (pattern << 1) | 0x01
                }
            } else {
                pattern <<= scaled
            }
        }
        pattern
    }