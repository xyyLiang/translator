    func isWhiteOrBlackRectangle(p1: Point, p2: Point, p3: Point, p4: Point): Bool {
        let corr = 3

        let p01 = Point(math.max(0, p1.x - corr), math.min(image.height - 1, p1.y + corr))
        let p02 = Point(math.max(0, p2.x - corr), math.max(0, p2.y - corr))
        let p03 = Point(
            math.min(image.width - 1, p3.x + corr),
            math.max(0, math.min(image.height - 1, p3.y - corr))
        )
        let p04 = Point(
            math.min(image.width - 1, p4.x + corr),
            math.min(image.height - 1, p4.y + corr)
        )

        let cInit = getColor(p4, p1)

        if (cInit == 0) {
            return false
        }

        var c = getColor(p1, p2)

        if (c != cInit) {
            return false
        }

        c = getColor(p2, p3)

        if (c != cInit) {
            return false
        }

        c = getColor(p3, p4)

        c == cInit
    }
