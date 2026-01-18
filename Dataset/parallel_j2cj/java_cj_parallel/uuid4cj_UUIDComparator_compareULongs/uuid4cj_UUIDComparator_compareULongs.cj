    @OverflowWrapping
    static func compareULongs(l1: Int64, l2: Int64): Int32 {
        var diffs: Int32 = compareUInts(Int32(l1 >> 32), Int32(l2 >> 32))
        if (diffs == 0) {
            diffs = compareUInts(Int32(l1), Int32(l2))
        }
        return diffs
    }