    protected static func appendPattern(target: Array<Bool>, oPos: Int64, pattern: Array<Int64>, startColor: Bool): Int64 {
        var pos = oPos
        for (bit in pattern) {
            target[pos] = bit != 0
            pos++
        }
        9
    }