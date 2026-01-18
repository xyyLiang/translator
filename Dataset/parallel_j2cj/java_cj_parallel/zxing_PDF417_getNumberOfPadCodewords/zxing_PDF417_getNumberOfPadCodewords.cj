    static func getNumberOfPadCodewords(m: Int64, k: Int64, c: Int64, r: Int64): Int64 {
        let n = c * r - k
        if (n > m + 1) {
            n - m - 1
        } else {
            0
        }
    }