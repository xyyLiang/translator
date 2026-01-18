    protected static func checkAndNudgePoints(image: BitMatrix, points: Array<Float64>) {
        let (width, height) = (image.width, image.height)

        var nudged = true
        let maxOffset = points.size - 1
        var offset = 0
        while (offset < maxOffset && nudged) {
            let x = Int64(points[offset])
            let y = Int64(points[offset + 1])
            if (x < -1 || x > width || y < -1 || y > height) {
                throw NotFoundException()
            }
            nudged = false
            if (x == -1) {
                points[offset] = 0.0
                nudged = true
            } else if (x == width) {
                points[offset] = Float64(width - 1)
                nudged = true
            }
            if (y == -1) {
                points[offset + 1] = 0.0
                nudged = true
            } else if (y == height) {
                points[offset + 1] = Float64(height - 1)
                nudged = true
            }
            offset += 2
        }
        nudged = true
        offset = points.size - 2
        while (offset >= 0 && nudged) {
            let x = Int64(points[offset])
            let y = Int64(points[offset + 1])
            if (x < -1 || x > width || y < -1 || y > height) {
                throw NotFoundException()
            }
            nudged = false
            if (x == -1) {
                points[offset] = 0.0
                nudged = true
            } else if (x == width) {
                points[offset] = Float64(width - 1)
                nudged = true
            }
            if (y == -1) {
                points[offset + 1] = 0.0
                nudged = true
            } else if (y == height) {
                points[offset + 1] = Float64(height - 1)
                nudged = true
            }
            offset -= 2
        }
    }