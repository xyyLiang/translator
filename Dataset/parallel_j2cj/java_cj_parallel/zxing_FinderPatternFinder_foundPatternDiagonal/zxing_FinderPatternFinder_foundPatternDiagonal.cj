func foundPatternDiagonal(stateCount: Array<Int64>): Bool {
    var totalModuleSize = 0
    for (i in 0..5) {
        let count = stateCount[i]
        if (count == 0) {
            return false
        }
        totalModuleSize += count
    }
    if (totalModuleSize < 7) {
        return false
    }
    let moduleSize = Float64(totalModuleSize) / 7.0
    let maxVariance = moduleSize / 1.333

    math.abs(moduleSize - Float64(stateCount[0])) < maxVariance && math.abs(moduleSize - Float64(stateCount[1])) <
        maxVariance && math.abs(3.0 * moduleSize - Float64(stateCount[2])) < 3.0 * maxVariance &&
        math.abs(moduleSize - Float64(stateCount[3])) < maxVariance && math.abs(moduleSize - Float64(stateCount[4])) <
        maxVariance
}