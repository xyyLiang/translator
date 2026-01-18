    static func toIntArray(a: Int64, toReturn: Array<Int64>) {
        for (i in 0..9) {
            toReturn[i] = if ((a & (1 << (8 - i))) == 0) {
                1
            } else {
                2
            }
        }
    }