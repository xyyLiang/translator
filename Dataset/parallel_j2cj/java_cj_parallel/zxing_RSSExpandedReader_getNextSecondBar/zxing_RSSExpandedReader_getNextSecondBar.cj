    static func getNextSecondBar(row: BitArray, initialPos: Int64): Int64 {
        if (row.get(initialPos)) {
            row.nextSet(row.nextUnset(initialPos))
        } else {
            row.nextUnset(row.nextSet(initialPos))
        }
    }