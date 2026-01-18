    func centerEdges(y: ResultPoint, z: ResultPoint, x: ResultPoint, t: ResultPoint): Array<ResultPoint> {
        let yi = y.x
        let yj = y.y
        let zi = z.x
        let zj = z.y
        let xi = x.x
        let xj = x.y
        let ti = t.x
        let tj = t.y

        let corr = Float64(CORR)
        if (yi < Float64(width) / 2.0) {
            [
                ResultPoint(ti - corr, tj + corr),
                ResultPoint(zi + corr, zj + corr),
                ResultPoint(xi - corr, xj - corr),
                ResultPoint(yi + corr, yj - corr)
            ]
        } else {
            [
                ResultPoint(ti + corr, tj + corr),
                ResultPoint(zi + corr, zj - corr),
                ResultPoint(xi - corr, xj + corr),
                ResultPoint(yi - corr, yj - corr)
            ]
        }
    }