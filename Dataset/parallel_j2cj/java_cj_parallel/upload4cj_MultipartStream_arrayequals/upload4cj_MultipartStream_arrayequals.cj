    public static func arrayequals(a: Array<UInt8>, b: Array<UInt8>, count: Int64): Bool {
        for (i in 0..count) {
            if (a[i] != b[i]) {
                return false
            }
        }
        return true
    }