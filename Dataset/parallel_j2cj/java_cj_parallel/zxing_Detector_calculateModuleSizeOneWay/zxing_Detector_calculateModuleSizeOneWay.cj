    func calculateModuleSizeOneWay(pattern: ResultPoint, otherPattern: ResultPoint): Float64 {
        let moduleSizeEst1 = sizeOfBlackWhiteBlackRunBothWays(
            Int64(pattern.x),
            Int64(pattern.y),
            Int64(otherPattern.x),
            Int64(otherPattern.y)
        )
        let moduleSizeEst2 = sizeOfBlackWhiteBlackRunBothWays(
            Int64(otherPattern.x),
            Int64(otherPattern.y),
            Int64(pattern.x),
            Int64(pattern.y)
        )
        if (Float64.NaN == moduleSizeEst1) {
            return moduleSizeEst2 / 7.0
        }
        if (Float64.NaN == moduleSizeEst2) {
            return moduleSizeEst1 / 7.0
        }
        return (moduleSizeEst1 + moduleSizeEst2) / 14.0
    }