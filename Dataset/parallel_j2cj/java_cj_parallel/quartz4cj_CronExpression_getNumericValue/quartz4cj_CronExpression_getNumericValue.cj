    private func getNumericValue(s: Array<Char>, i: Int64): Int64 {
        let endOfVal = findNextWhiteSpace(i, s)
        let val = newString(s,i, endOfVal - i)
        return Int64.parse(val)
    }   