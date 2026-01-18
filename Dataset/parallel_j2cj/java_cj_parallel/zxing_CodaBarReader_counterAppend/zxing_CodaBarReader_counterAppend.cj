    func counterAppend(e: Int64) {
        counters[counterLength] = e
        counterLength++
        if (counterLength >= counters.size) {
            let temp = Array<Int64>(counterLength * 2, item: 0)
            counters.copyTo(temp, 0, 0, counterLength)
            counters = temp
        }
    }