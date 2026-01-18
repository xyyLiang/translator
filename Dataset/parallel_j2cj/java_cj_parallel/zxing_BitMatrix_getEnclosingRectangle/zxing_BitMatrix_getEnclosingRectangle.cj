    public func getEnclosingRectangle(): ?Array<Int64> {
        var left = this.width
        var top = this.height
        var right = -1
        var bottom = -1

        for (y in 0..height) {
            for (x32 in 0..rowSize) {
                let theBits = bits[y * rowSize + x32]
                if (theBits != 0) {
                    if (y < top) {
                        top = y
                    }
                    if (y > bottom) {
                        bottom = y
                    }
                    if (x32 * 32 < left) {
                        var bit = 0
                        while ((theBits << (31 - bit)) == 0) {
                            bit++
                        }
                        if ((x32 * 32 + bit) < left) {
                            left = x32 * 32 + bit
                        }
                    }
                    if (x32 * 32 + 31 > right) {
                        var bit = 31
                        while (Int64(UInt64(theBits) >> bit) == 0) {
                            bit--
                        }
                        if ((x32 * 32 + bit) > right) {
                            right = x32 * 32 + bit
                        }
                    }
                }
            }
        }

        if (right < left || bottom < top) {
            return None
        }

        return [left, top, right - left + 1, bottom - top + 1]
    }