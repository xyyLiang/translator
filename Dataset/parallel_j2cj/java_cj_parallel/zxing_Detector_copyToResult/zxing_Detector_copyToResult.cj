    static func copyToResult(
        result: Array<?ResultPoint>,
        tmpResult: Array<?ResultPoint>,
        destinationIndexes: Array<Int64>
    ) {
        for (i in 0..destinationIndexes.size) {
            result[destinationIndexes[i]] = tmpResult[i]
        }
    }