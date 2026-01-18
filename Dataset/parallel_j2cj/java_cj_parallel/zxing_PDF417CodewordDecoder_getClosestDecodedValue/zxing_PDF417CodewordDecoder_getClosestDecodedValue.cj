    static func getClosestDecodedValue(moduleBitCount: Array<Int64>): Int64 {
        let bitCountSum = util.sum(moduleBitCount)
        let bitCountRatios = Array<Float64>(PDF417Common.BARS_IN_MODULE, item: 0.0)
        if (bitCountSum > 1) {
            let m = Float64(bitCountSum)
            for (i in 0..bitCountRatios.size) {
                bitCountRatios[i] = Float64(moduleBitCount[i]) / m
            }
        }
        var bestMatchError = Float64.Max
        var bestMatch = -1
        for (j in 0..RATIOS_TABLE.size) {
            var error = 0.0
            let ratioTableRow = RATIOS_TABLE[j]
            for (k in 0..PDF417Common.BARS_IN_MODULE) {
                let diff = ratioTableRow[k] - bitCountRatios[k]
                error += diff * diff
                if (error >= bestMatchError) {
                    break
                }
            }
            if (error < bestMatchError) {
                bestMatchError = error
                bestMatch = PDF417Common.SYMBOL_TABLE[j]
            }
        }
        bestMatch
    }