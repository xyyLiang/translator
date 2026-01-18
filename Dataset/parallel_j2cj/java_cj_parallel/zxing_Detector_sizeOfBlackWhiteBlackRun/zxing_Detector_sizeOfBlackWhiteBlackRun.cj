    func sizeOfBlackWhiteBlackRun(oFromX: Int64, oFromY: Int64, oToX: Int64, oToY: Int64): Float64 {
        let steep = math.abs(oToY - oFromY) > math.abs(oToX - oFromX)
        let (fromX, fromY, toX, toY) = if (steep) {
            (oFromY, oFromX, oToY, oToX)
        } else {
            (oFromX, oFromY, oToX, oToY)
        }

        let dx = math.abs(toX - fromX)
        var dy = math.abs(toY - fromY)
        var error = -dx / 2

        let xstep = if (fromX < toX) {
            1
        } else {
            -1
        }
        let ystep = if (fromY < toY) {
            1
        } else {
            -1
        }

        var state = 0
        var x = fromX
        var y = fromY
        while (x != (toX + xstep)) {
            let (realX, realY) = if (steep) {
                (y, x)
            } else {
                (x, y)
            }

            if ((state == 1) == image.get(realX, realY)) {
                if (state == 2) {
                    return distance(x, y, fromX, fromY)
                }
                state++
            }

            error += dy
            if (error > 0) {
                if (y == toY) {
                    break
                }
                y += ystep
                error -= dx
            }

            x += xstep
        }

        if (state == 2) {
            return distance(toX + xstep, toY, fromX, fromY)
        }

        Float64.NaN
    }