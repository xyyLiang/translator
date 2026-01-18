    func combineEstimate(i: Float64, j: Float64, newModuleSize: Float64): AlignmentPattern {
        let combinedX = (x + j) / 2.0
        let combinedY = (y + i) / 2.0
        let combinedModuleSize = (estimatedModuleSize + newModuleSize) / 2.0
        AlignmentPattern(combinedX, combinedY, combinedModuleSize)
    }