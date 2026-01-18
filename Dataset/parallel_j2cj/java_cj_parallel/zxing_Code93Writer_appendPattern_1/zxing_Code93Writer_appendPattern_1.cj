    static func appendPattern(target: Array<Bool>, pos: Int64, a: Int64): Int64 {
        for (i in 0..9) {
            target[pos + i] = (a & (1 << (8 - i))) != 0
        }
        9
    }