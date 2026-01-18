    func aboutEquals(moduleSize: Float64, i: Float64, j: Float64): Bool {
        if (math.abs(i - y) <= moduleSize && math.abs(j - x) <= moduleSize) {
            let moduleSizeDiff = math.abs(moduleSize - estimatedModuleSize)
            moduleSizeDiff <= 1.0 || moduleSizeDiff <= estimatedModuleSize
        } else {
            false
        }
    }
