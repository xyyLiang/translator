    protected static func appendPattern(target: Array<Bool>, oPos: Int64, pattern: Array<Int64>, startColor: Bool): Int64 {
        var color = startColor
        var numAdded = 0
        var pos = oPos
        for (len in pattern) {
            for (j in 0..len) {
                target[pos] = color
                pos++
            }
            numAdded += len
            color = !color
        }
        numAdded
    }