    func combineEstimate(i: Float64, j: Float64, newModuleSize: Float64): FinderPattern {
        let combinedCount = count + 1
        let combinedX = (Float64(count) * x + j) / Float64(combinedCount)
        let combinedY = (Float64(count) * y + i) / Float64(combinedCount)
        let combinedModuleSize = (Float64(count) * estimatedModuleSize + newModuleSize) / Float64(combinedCount)
        FinderPattern(combinedX, combinedY, combinedModuleSize, combinedCount)
    }