    func getBlackPointOnSegment(aX: Int64, aY: Int64, bX: Int64, bY: Int64): ?ResultPoint {
        let dist = math.round(distance(aX, aY, bX, bY))
        let xStep = Float64(bX - aX) / dist
        let yStep = Float64(bY - aY) / dist

        for (i in 0..Int64(dist)) {
            let x = math.round(Float64(aX) + Float64(i) * xStep)
            let y = math.round(Float64(aY) + Float64(i) * yStep)
            if (image.get(Int64(x), Int64(y))) {
                return ResultPoint(x, y)
            }
        }
        None
    }