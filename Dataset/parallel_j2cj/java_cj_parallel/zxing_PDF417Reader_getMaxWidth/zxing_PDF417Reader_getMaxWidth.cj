    static func getMaxWidth(p1: ?ResultPoint, p2: ?ResultPoint): Int64 {
        if (let (Some(v1), Some(v2)) = (p1, p2)) {
            math.abs(Int64(v1.x - v2.x))
        } else {
            0
        }
    }