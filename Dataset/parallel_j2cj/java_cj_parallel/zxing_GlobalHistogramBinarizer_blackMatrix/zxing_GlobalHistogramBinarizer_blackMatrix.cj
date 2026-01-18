    public open func blackMatrix(): BitMatrix {
        let width = source.width
        let height = source.height
        let matrix = BitMatrix(width, height)

        initArrays(width)
        let localBuckets = buckets
        for (y in 1..5) {
            let row = height * y / 5
            let localLuminances = source.row(row, luminances)
            let right = (width * 4) / 5
            for (x in (width / 5)..right) {
                let pixel = localLuminances[x] & Int8(0xff)
                localBuckets[Int64(pixel >> LUMINANCE_SHIFT)] += 1
            }
        }
        let blackPoint = estimateBlackPoint(localBuckets)

        let localLuminances = source.matrix()
        for (y in 0..height) {
            let offset = y * width
            for (x in 0..width) {
                let pixel = Int64(localLuminances[offset + x] & 0xff)
                if (pixel < blackPoint) {
                    matrix.set(x, y)
                }
            }
        }
        matrix
    }
