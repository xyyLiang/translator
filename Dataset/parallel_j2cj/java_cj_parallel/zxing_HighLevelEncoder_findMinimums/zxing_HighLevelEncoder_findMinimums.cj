    static func findMinimums(charCounts: Array<Float64>, intCharCounts: Array<Int64>, omin: Int64, mins: Array<UInt8>): Int64 {
        var min = omin
        for (i in 0..6) {
            let current = Int64(math.ceil(charCounts[i]))
            intCharCounts[i] = current
            if (min > current) {
                min = current
                for (j in 0..mins.size) {
                    mins[j] = 0
                }
            }
            if (min == current) {
                mins[i] += 1
            }
        }
        min
    }