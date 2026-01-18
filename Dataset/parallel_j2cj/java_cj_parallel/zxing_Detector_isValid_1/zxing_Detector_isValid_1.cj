    func isValid(point: ResultPoint): Bool {
        let x = Int64(math.round(point.x))
        let y = Int64(math.round(point.y))
        return isValid(x, y)
    }