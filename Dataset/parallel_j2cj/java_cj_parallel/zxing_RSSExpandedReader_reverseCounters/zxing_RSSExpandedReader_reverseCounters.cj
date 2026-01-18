    static func reverseCounters(counters: Array<Int64>) {
        let length = counters.size
        for (i in 0..(length / 2)) {
            let tmp = counters[i]
            counters[i] = counters[length - i - 1]
            counters[length - i - 1] = tmp
        }
    }
