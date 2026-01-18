    public static func isArrayZero(a: Array<Byte>, size: Int64): Bool {
        for (i in 0..size where a[i] != 0) {
            return false
        }
        return true
    }