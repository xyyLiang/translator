    func createTransform<T>(
        topLeft: ResultPoint,
        topRight: ResultPoint,
        bottomLeft: ResultPoint,
        alignmentPattern: ?T,
        dimension: Int64
    ): PerspectiveTransform where T <: ResultPoint {
        let dimMinusThree = Float64(dimension) - 3.5

        let (bottomRightX, bottomRightY, sourceBottomRightX, sourceBottomRightY) = if (let Some(pattern) = alignmentPattern) {
            (pattern.x, pattern.y, dimMinusThree - 3.0, dimMinusThree - 3.0)
        } else {
            ((topRight.x - topLeft.x) + bottomLeft.x, (topRight.y - topLeft.y) + bottomLeft.y, dimMinusThree,
                dimMinusThree)
        }

        PerspectiveTransform.quadrilateralToQuadrilateral(
            3.5,
            3.5,
            dimMinusThree,
            3.5,
            sourceBottomRightX,
            sourceBottomRightY,
            3.5,
            dimMinusThree,
            topLeft.x,
            topLeft.y,
            topRight.x,
            topRight.y,
            bottomRightX,
            bottomRightY,
            bottomLeft.x,
            bottomLeft.y
        )
    }