    static func regionMatches(a: CharArray, startA: Int64, endA: Int64, b: CharArray, startB: Int64, endB: Int64): Bool {
        let n = endA - startA
        if (endB - startB != n) {
            return false
        }
        return a.slice(startA, endA-startA) == b.slice(startB, endB-startB)
    }