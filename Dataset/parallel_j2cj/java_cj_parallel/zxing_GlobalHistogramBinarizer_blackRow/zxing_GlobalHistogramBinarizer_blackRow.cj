    @overflowWrapping
    public func blackRow(y: Int64, r: BitArray): BitArray {
        let width = source.width
        let row = if (r.size < width) {
            BitArray(width)
        } else {
            r.clear()
            r
        }

        initArrays(width)
        let localLuminances = source.row(y, luminances)
        let localBuckets = buckets
        for (x in 0..width) {
            localBuckets[Int64((UInt8(localLuminances[x]) & 0xff) >> LUMINANCE_SHIFT)] += 1
        }
        let blackPoint = estimateBlackPoint(localBuckets)

        if (width < 3) {
            for (x in 0..width) {
                if (Int64(UInt8(localLuminances[x]) & 0xff) < blackPoint) {
                    row.set(x)
                }
            }
        } else {
            var left = Int64(UInt8(localLuminances[0]) & 0xff)
            var center =Int64( UInt8(localLuminances[1]) & 0xff)
            for (x in 1..(width - 1)) {
                let right = Int64(UInt8(localLuminances[x + 1]) & 0xff)
                if (((center * 4) - left - right) / 2 < blackPoint) {
                    row.set(x)
                }
                left = center
                center = right
            }
        }
        row
    }
