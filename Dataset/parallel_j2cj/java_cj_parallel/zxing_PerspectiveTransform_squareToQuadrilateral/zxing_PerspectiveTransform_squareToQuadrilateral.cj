    public static func squareToQuadrilateral(
        x0: Float64,
        y0: Float64,
        x1: Float64,
        y1: Float64,
        x2: Float64,
        y2: Float64,
        x3: Float64,
        y3: Float64
    ): PerspectiveTransform {
        let dx3 = x0 - x1 + x2 - x3
        let dy3 = y0 - y1 + y2 - y3
        if (dx3 == 0.0 && dy3 == 0.0) {
            PerspectiveTransform(
                x1 - x0,
                x2 - x1,
                x0,
                y1 - y0,
                y2 - y1,
                y0,
                0.0,
                0.0,
                1.0
            )
        } else {
            let dx1 = x1 - x2
            let dx2 = x3 - x2
            let dy1 = y1 - y2
            let dy2 = y3 - y2
            let denominator = dx1 * dy2 - dx2 * dy1
            let a13 = (dx3 * dy2 - dx2 * dy3) / denominator
            let a23 = (dx1 * dy3 - dx3 * dy1) / denominator
            PerspectiveTransform(
                x1 - x0 + a13 * x1,
                x3 - x0 + a23 * x3,
                x0,
                y1 - y0 + a13 * y1,
                y3 - y0 + a23 * y3,
                y0,
                a13,
                a23,
                1.0
            )
        }
    }
