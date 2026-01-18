    func addMissingRows(missingStartRows: Int64, missingEndRows: Int64, isLeft: Bool): BoundingBox {
        var newTopLeft = topLeft
        var newBottomLeft = bottomLeft
        var newTopRight = topRight
        var newBottomRight = bottomRight

        if (missingStartRows > 0) {
            let top = if (isLeft) {
                topLeft
            } else {
                topRight
            }
            var newMinY = Int64(top.y) - missingStartRows
            if (newMinY < 0) {
                newMinY = 0
            }
            let newTop = ResultPoint(top.x, Float64(newMinY))
            if (isLeft) {
                newTopLeft = newTop
            } else {
                newTopRight = newTop
            }
        }

        if (missingEndRows > 0) {
            let bottom = if (isLeft) {
                bottomLeft
            } else {
                bottomRight
            }
            var newMaxY = Int64(bottom.y) + missingEndRows
            if (newMaxY >= image.height) {
                newMaxY = image.height - 1
            }
            let newBottom = ResultPoint(bottom.x, Float64(newMaxY))
            if (isLeft) {
                newBottomLeft = newBottom
            } else {
                newBottomRight = newBottom
            }
        }

        BoundingBox(image, newTopLeft, newBottomLeft, newTopRight, newBottomRight)
    }