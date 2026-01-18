    public func setRegion(left: Int64, top: Int64, width: Int64, height: Int64) {
        if (top < 0 || left < 0) {
            throw IllegalArgumentException("Left and top must be nonnegative")
        }
        if (height < 1 || width < 1) {
            throw IllegalArgumentException("Height and width must be at least 1")
        }
        let right = left + width
        let bottom = top + height
        if (bottom > this.height || right > this.width) {
            throw IllegalArgumentException("The region must fit inside the matrix")
        }
        for (y in top..bottom) {
            let offset = y * rowSize
            for (x in left..right) {
                bits[offset + (x / 32)] |= 1 << (x & 0x1f)
            }
        }
    }
