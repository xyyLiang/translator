    func haveMultiplyConfirmedCenters(): Bool {
        var confirmedCount = 0
        var totalModuleSize = 0.0
        let max = Float64(possibleCenters.size)
        for (pattern in possibleCenters) {
            if (pattern.count >= CENTER_QUORUM) {
                confirmedCount++
                totalModuleSize += pattern.estimatedModuleSize
            }
        }
        if (confirmedCount < 3) {
            return false
        }

        let average = totalModuleSize / max
        var totalDeviation = 0.0
        for (pattern in possibleCenters) {
            totalDeviation += math.abs(pattern.estimatedModuleSize - average)
        }
        return totalDeviation <= 0.05 * totalModuleSize
    }