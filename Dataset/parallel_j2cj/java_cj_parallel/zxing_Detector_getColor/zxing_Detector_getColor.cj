    func getColor(p1: Point, p2: Point): Int64 {
        let d = distance(p1, p2)
        if (d == 0.0) {
            return 0
        }
        let dx = Float64(p2.x - p1.x) / d
        let dy = Float64(p2.y - p1.y) / d
        var error = 0

        var px = Float64(p1.x)
        var py = Float64(p1.y)

        let colorModel = image.get(p1.x, p1.y)

        let iMax = Int64(math.floor(d))
        for (i in 0..iMax) {
            if (image.get(round(px), round(py)) != colorModel) {
                error++
            }
            px += dx
            py += dy
        }

        let errRatio = Float64(error) / d

        if (errRatio > 0.1 && errRatio < 0.9) {
            return 0
        }

        if ((errRatio <= 0.1) == colorModel) {
            1
        } else {
            -1
        }
    }