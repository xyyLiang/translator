    static func getBitValue(moduleBitCount: Array<Int64>): Int64 {
        var result = 0
        for (i in 0..moduleBitCount.size) {
            for (bit in 0..moduleBitCount[i]) {
                result = (result << 1) | if (i % 2 == 0) {
                    1
                } else {
                    0
                }
            }
        }
        result
    }