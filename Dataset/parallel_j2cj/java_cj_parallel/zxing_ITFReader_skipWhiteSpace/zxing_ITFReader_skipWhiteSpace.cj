    static func skipWhiteSpace(row: BitArray): Int64 {
        let width = row.size
        let endStart = row.nextSet(0)
        if (endStart == width) {
            throw NotFoundException()
        }
        endStart
    }