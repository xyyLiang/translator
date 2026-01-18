    func aboutEquals(moduleSize: Float64, i: Float64, j: Float64): Bool {
        if (math.abs(i - x) <= moduleSize && math.abs(j - y) <= moduleSize) {
            let moduleSizeDiff = math.abs(moduleSize - estimatedModuleSize)
            moduleSizeDiff <= 1.0 || moduleSizeDiff <= estimatedModuleSize
        } else {
            false
        }
    }