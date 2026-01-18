    private static func vswap(fmap: Array<Int64>, p1i64: Int64, p2i64: Int64, n: Int64): Unit {
        var p1: Int64 = p1i64
        var p2: Int64 = p2i64
        let max = n + p1
        while (p1 < max) {
            let t: Int64 = fmap[p1]
            fmap[p1] = fmap[p2]
            p1++
            fmap[p2] = t
            p2++
        }
    }