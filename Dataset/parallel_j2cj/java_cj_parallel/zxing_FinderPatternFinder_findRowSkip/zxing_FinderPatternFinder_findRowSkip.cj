    func findRowSkip(): Int64 {
        let max = possibleCenters.size
        if (max <= 1) {
            return 0
        }
        var firstConfirmedCenter: ?ResultPoint = None
        for (center in possibleCenters) {
            if (center.count >= CENTER_QUORUM) {
                if (let None = firstConfirmedCenter) {
                    firstConfirmedCenter = center
                } else {
                    hasSkipped = true
                    let result = 
                        Int64(math.abs(firstConfirmedCenter.getOrThrow().x - center.x) - math.abs(
                            firstConfirmedCenter.getOrThrow().y - center.y)) / 2
                    return result
                }
            }
        }
        0
    }