    func getMatrixCenter(): Point {
        var pointA = ResultPoint(0.0, 0.0)
        var pointB = ResultPoint(0.0, 0.0)
        var pointC = ResultPoint(0.0, 0.0)
        var pointD = ResultPoint(0.0, 0.0)

        try {
            let cornerPoints = WhiteRectangleDetector(image).detect()
            pointA = cornerPoints[0]
            pointB = cornerPoints[1]
            pointC = cornerPoints[2]
            pointD = cornerPoints[3]
        } catch (e: NotFoundException) {
            let cx = image.width / 2
            let cy = image.height / 2
            pointA = getFirstDifferent(Point(cx + 7, cy - 7), false, 1, -1).toResultPoint()
            pointB = getFirstDifferent(Point(cx + 7, cy + 7), false, 1, 1).toResultPoint()
            pointC = getFirstDifferent(Point(cx - 7, cy + 7), false, -1, 1).toResultPoint()
            pointD = getFirstDifferent(Point(cx - 7, cy - 7), false, -1, -1).toResultPoint()
        }
        var cx = Int64(math.round((pointA.x + pointD.x + pointB.x + pointC.x) / 4.0))
        var cy = Int64(math.round((pointA.y + pointD.y + pointB.y + pointC.y) / 4.0))

        try {
            let cornerPoints = WhiteRectangleDetector(image, 15, cx, cy).detect()
            pointA = cornerPoints[0]
            pointB = cornerPoints[1]
            pointC = cornerPoints[2]
            pointD = cornerPoints[3]
        } catch (e: NotFoundException) {
            pointA = getFirstDifferent(Point(cx + 7, cy - 7), false, 1, -1).toResultPoint()
            pointB = getFirstDifferent(Point(cx + 7, cy + 7), false, 1, 1).toResultPoint()
            pointC = getFirstDifferent(Point(cx - 7, cy + 7), false, -1, 1).toResultPoint()
            pointD = getFirstDifferent(Point(cx - 7, cy - 7), false, -1, -1).toResultPoint()
        }
        cx = Int64(math.round((pointA.x + pointD.x + pointB.x + pointC.x) / 4.0))
        cy = Int64(math.round((pointA.y + pointD.y + pointB.y + pointC.y) / 4.0))

        Point(cx, cy)
    }
