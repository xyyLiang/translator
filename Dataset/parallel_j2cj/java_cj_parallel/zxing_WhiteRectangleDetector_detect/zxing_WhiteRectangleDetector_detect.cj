    public func detect(): Array<ResultPoint> {
        var left = leftInit
        var right = rightInit
        var up = upInit
        var down = downInit
        var sizeExceeded = false
        var aBlackPointFoundOnBorder = true

        var atLeastOneBlackPointFoundOnRight = false
        var atLeastOneBlackPointFoundOnBottom = false
        var atLeastOneBlackPointFoundOnLeft = false
        var atLeastOneBlackPointFoundOnTop = false

        while (aBlackPointFoundOnBorder) {
            aBlackPointFoundOnBorder = false

            var rightBorderNotWhite = true
            while ((rightBorderNotWhite || !atLeastOneBlackPointFoundOnRight) && right < width) {
                rightBorderNotWhite = containsBlackPoint(up, down, right, false)
                if (rightBorderNotWhite) {
                    right++
                    aBlackPointFoundOnBorder = true
                    atLeastOneBlackPointFoundOnRight = true
                } else if (!atLeastOneBlackPointFoundOnRight) {
                    right++
                }
            }

            if (right >= width) {
                sizeExceeded = true
                break
            }

            var bottomBorderNotWhite = true
            while ((bottomBorderNotWhite || !atLeastOneBlackPointFoundOnBottom) && down < height) {
                bottomBorderNotWhite = containsBlackPoint(left, right, down, true)
                if (bottomBorderNotWhite) {
                    down++
                    aBlackPointFoundOnBorder = true
                    atLeastOneBlackPointFoundOnBottom = true
                } else if (!atLeastOneBlackPointFoundOnBottom) {
                    down++
                }
            }

            if (down >= height) {
                sizeExceeded = true
                break
            }

            var leftBorderNotWhite = true
            while ((leftBorderNotWhite || !atLeastOneBlackPointFoundOnLeft) && left >= 0) {
                leftBorderNotWhite = containsBlackPoint(up, down, left, false)
                if (leftBorderNotWhite) {
                    left--
                    aBlackPointFoundOnBorder = true
                    atLeastOneBlackPointFoundOnLeft = true
                } else if (!atLeastOneBlackPointFoundOnLeft) {
                    left--
                }
            }

            if (left < 0) {
                sizeExceeded = true
                break
            }

            var topBorderNotWhite = true
            while ((topBorderNotWhite || !atLeastOneBlackPointFoundOnTop) && up >= 0) {
                topBorderNotWhite = containsBlackPoint(left, right, up, true)
                if (topBorderNotWhite) {
                    up--
                    aBlackPointFoundOnBorder = true
                    atLeastOneBlackPointFoundOnTop = true
                } else if (!atLeastOneBlackPointFoundOnTop) {
                    up--
                }
            }

            if (up < 0) {
                sizeExceeded = true
                break
            }
        }

        if (!sizeExceeded) {
            let maxSize = right - left

            var z: ?ResultPoint = None
            var i = 1
            while (i < maxSize) {
                if (let Some(v) = z) {
                    break
                }
                z = getBlackPointOnSegment(left, down - i, left + i, down)
                i++
            }

            if (let None = z) {
                throw NotFoundException()
            }

            var t: ?ResultPoint = None
            i = 1
            while (i < maxSize) {
                if (let Some(v) = t) {
                    break
                }
                t = getBlackPointOnSegment(left, up + i, left + i, up)
                i++
            }

            if (let None = t) {
                throw NotFoundException()
            }

            var x: ?ResultPoint = None
            i = 1
            while (i < maxSize) {
                if (let Some(v) = x) {
                    break
                }
                x = getBlackPointOnSegment(right, up + i, right - i, up)
                i++
            }

            if (let None = x) {
                throw NotFoundException()
            }

            var y: ?ResultPoint = None
            i = 1
            while (i < maxSize) {
                if (let Some(v) = y) {
                    break
                }
                y = getBlackPointOnSegment(right, down - i, right - i, down)
                i++
            }

            if (let None = y) {
                throw NotFoundException()
            }

            centerEdges(y.getOrThrow(), z.getOrThrow(), x.getOrThrow(), t.getOrThrow())
        } else {
            throw NotFoundException()
        }
    }