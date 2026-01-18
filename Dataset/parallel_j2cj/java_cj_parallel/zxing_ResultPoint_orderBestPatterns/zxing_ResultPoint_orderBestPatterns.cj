public func orderBestPatterns<T>(patterns: Array<T>) where T <: ResultPoint {
    let zeroOneDistance = distance(patterns[0], patterns[1])
    let oneTwoDistance = distance(patterns[1], patterns[2])
    let zeroTwoDistance = distance(patterns[0], patterns[2])

    let (pointB, pointA, pointC) = if (oneTwoDistance >= zeroOneDistance && oneTwoDistance >= zeroTwoDistance) {
        (patterns[0], patterns[1], patterns[2])
    } else if (zeroTwoDistance >= oneTwoDistance && zeroTwoDistance >= zeroOneDistance) {
        (patterns[1], patterns[0], patterns[2])
    } else {
        (patterns[2], patterns[0], patterns[1])
    }

    if (crossProductZ(pointA, pointB, pointC) < 0.0) {
        patterns[0] = pointC
        patterns[1] = pointB
        patterns[2] = pointA
    } else {
        patterns[0] = pointA
        patterns[1] = pointB
        patterns[2] = pointC
    }
}