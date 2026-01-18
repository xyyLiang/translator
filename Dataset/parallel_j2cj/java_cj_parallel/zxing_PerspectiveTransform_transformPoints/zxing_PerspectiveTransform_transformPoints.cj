    public func transformPoints(points: Array<Float64>) {
        for (i in 0..points.size : 2) {
            let x = points[i]
            let y = points[i + 1]
            let denominator = a13 * x + a23 * y + a33
            points[i] = (a11 * x + a21 * y + a31) / denominator
            points[i + 1] = (a12 * x + a22 * y + a32) / denominator
        }
    }