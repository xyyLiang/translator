    static func calculateNumberOfRows(m: Int64, k: Int64, c: Int64): Int64 {
        var r = ((m + 1 + k) / c) + 1
        if (c * r >= (m + 1 + k + c)) {
            r--
        }
        r
    }