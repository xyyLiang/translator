    static func getMax(values: Array<Int64>): Int64 {
        var maxValue = -1
        for (value in values) {
            maxValue = math.max(maxValue, value)
        }
        maxValue
    }