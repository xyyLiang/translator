    func sampleLine(p1: ResultPoint, p2: ResultPoint, size: Int64): Int64 {
        var result = 0

        let d = distance(p1, p2)
        let moduleSize = d / Float64(size)
        let px = p1.x
        let py = p1.y
        let dx = moduleSize * (p2.x - p1.x) / d
        let dy = moduleSize * (p2.y - p1.y) / d
        for (i in 0..size) {
            let f = Float64(i)
            if (image.get(round(px + f * dx), round(py + f * dy))) {
                result |= 1 << (size - i - 1)
            }
        }
        result
    }