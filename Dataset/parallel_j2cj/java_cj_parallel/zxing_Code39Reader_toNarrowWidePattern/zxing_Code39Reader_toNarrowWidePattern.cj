    static func toNarrowWidePattern(counters: Array<Int64>): Int64 {
        let numCounters = counters.size
        var maxNarrowCounter = 0
        var wideCounters = 0
        do {
            var minCounter = Int64.Max
            for (counter in counters) {
                if (counter < minCounter && counter > maxNarrowCounter) {
                    minCounter = counter
                }
            }
            maxNarrowCounter = minCounter
            wideCounters = 0
            var totalWideCountersWidth = 0
            var pattern = 0
            for (i in 0..numCounters) {
                let counter = counters[i]
                if (counter > maxNarrowCounter) {
                    pattern |= 1 << (numCounters - 1 - i)
                    wideCounters++
                    totalWideCountersWidth += counter
                }
            }
            if (wideCounters == 3) {
                for (i in 0..numCounters) {
                    if (wideCounters <= 0) {
                        break
                    }
                    let counter = counters[i]
                    if (counter > maxNarrowCounter) {
                        wideCounters--
                        if ((counter * 2) >= totalWideCountersWidth) {
                            return -1
                        }
                    }
                }
                return pattern
            }
        } while (wideCounters > 3)
        -1
    }