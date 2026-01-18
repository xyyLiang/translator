    func foundPatternCross(stateCount: Array<Int64>): Bool {
        let moduleSize = this.moduleSize
        let maxVariance = moduleSize / 2.0
        for (i in 0..3) {
            if (math.abs(moduleSize - Float64(stateCount[i])) >= maxVariance) {
                return false
            }
        }
        true
    }