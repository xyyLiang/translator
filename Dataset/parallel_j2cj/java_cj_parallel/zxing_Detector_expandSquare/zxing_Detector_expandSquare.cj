    static func expandSquare(cornerPoints: Array<ResultPoint>, oldSide: Int64, newSide: Int64): Array<ResultPoint> {
        let ratio = Float64(newSide) / Float64(2 * oldSide)
        var dx = cornerPoints[0].x - cornerPoints[2].x
        var dy = cornerPoints[0].y - cornerPoints[2].y
        var centerx = (cornerPoints[0].x + cornerPoints[2].x) / 2.0
        var centery = (cornerPoints[0].y + cornerPoints[2].y) / 2.0

        let result0 = ResultPoint(centerx + ratio * dx, centery + ratio * dy)
        let result2 = ResultPoint(centerx - ratio * dx, centery - ratio * dy)

        dx = cornerPoints[1].x - cornerPoints[3].x
        dy = cornerPoints[1].y - cornerPoints[3].y
        centerx = (cornerPoints[1].x + cornerPoints[3].x) / 2.0
        centery = (cornerPoints[1].y + cornerPoints[3].y) / 2.0
        let result1 = ResultPoint(centerx + ratio * dx, centery + ratio * dy)
        let result3 = ResultPoint(centerx - ratio * dx, centery - ratio * dy)

        [result0, result1, result2, result3]
    }