    func getFirstDifferent(ini: Point, color: Bool, dx: Int64, dy: Int64): Point {
        var x = ini.x + dx
        var y = ini.y + dy

        while (isValid(x, y) && image.get(x, y) == color) {
            x += dx
            y += dy
        }

        x -= dx
        y -= dy

        while (isValid(x, y) && image.get(x, y) == color) {
            x += dx
        }
        x -= dx

        while (isValid(x, y) && image.get(x, y) == color) {
            y += dy
        }
        y -= dy

        Point(x, y)
    }