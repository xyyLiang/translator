    static func estimateBlackPoint(buckets: Array<Int64>): Int64 {
        let numBuckets = buckets.size
        var maxBucketCount = 0
        var firstPeak = 0
        var firstPeakSize = 0
        for (x in 0..numBuckets) {
            if (buckets[x] > firstPeakSize) {
                firstPeak = x
                firstPeakSize = buckets[x]
            }
            if (buckets[x] > maxBucketCount) {
                maxBucketCount = buckets[x]
            }
        }

        var secondPeak = 0
        var secondPeakScore = 0
        for (x in 0..numBuckets) {
            let distanceToBiggest = x - firstPeak
            let score = buckets[x] * distanceToBiggest * distanceToBiggest
            if (score > secondPeakScore) {
                secondPeak = x
                secondPeakScore = score
            }
        }

        if (firstPeak > secondPeak) {
            let temp = firstPeak
            firstPeak = secondPeak
            secondPeak = temp
        }

        if (secondPeak - firstPeak <= numBuckets / 16) {
            throw NotFoundException()
        }

        var bestValley = secondPeak - 1
        var bestValleyScore = -1
        for (x in (secondPeak - 1)..firstPeak : -1) {
            let fromFirst = x - firstPeak
            let score = fromFirst * fromFirst * (secondPeak - x) * (maxBucketCount - buckets[x])
            if (score > bestValleyScore) {
                bestValley = x
                bestValleyScore = score
            }
        }

        bestValley << LUMINANCE_SHIFT
    }