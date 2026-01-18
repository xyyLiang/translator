    protected static func decrement(array: Array<Int64>, errors: Array<Float64>) {
        var index = 0
        var biggestError = errors[0]
        for (i in 1..array.size) {
            if (errors[i] < biggestError) {
                biggestError = errors[i]
                index = i
            }
        }
        array[index] -= 1
    }