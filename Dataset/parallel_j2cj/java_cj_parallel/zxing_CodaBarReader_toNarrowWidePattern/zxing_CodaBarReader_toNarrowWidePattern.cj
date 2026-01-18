    func toNarrowWidePattern(position: Int64): Int64 {
        let end = position + 7
        if (end >= counterLength) {
            return -1
        }

        let theCounters = counters

        var maxBar = 0
        var minBar = Int64.Max
        for (j in position..end : 2) {
            let currentCounter = theCounters[j]
            if (currentCounter < minBar) {
                minBar = currentCounter
            }
            if (currentCounter > maxBar) {
                maxBar = currentCounter
            }
        }
        let thresholdBar = (minBar + maxBar) / 2

        var maxSpace = 0
        var minSpace = Int64.Max
        for (j in position..end : 2) {
            let currentCounter = theCounters[j]
            if (currentCounter < minSpace) {
                minSpace = currentCounter
            }
            if (currentCounter > maxSpace) {
                maxSpace = currentCounter
            }
        }
        let thresholdSpace = (minSpace + maxSpace) / 2

        var bitmask = 1 << 7
        var pattern = 0
        for (i in 0..7) {
            let threshold = if ((i & 1) == 0) {
                thresholdBar
            } else {
                thresholdSpace
            }
            bitmask >>= 1
            if (theCounters[position + i] > threshold) {
                pattern |= bitmask
            }
        }

        for (i in 0..CHARACTER_ENCODINGS.size) {
            if (CHARACTER_ENCODINGS[i] == pattern) {
                return i
            }
        }
        -1
    }