    func setCounters(row: BitArray) {
        counterLength = 0
        var i = row.nextUnset(0)
        let end = row.size
        if (i >= end) {
            throw NotFoundException()
        }
        var isWhite = true
        var count = 0
        while (i < end) {
            if (row.get(i) != isWhite) {
                count++
            } else {
                counterAppend(count)
                count = 1
                isWhite = !isWhite
            }
            i++
        }
        counterAppend(count)
    }