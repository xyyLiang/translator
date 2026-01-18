    func decodeEnd(row: BitArray): Array<Int64> {
        row.reverse()
        try {
            let endStart = skipWhiteSpace(row)
            let endPattern = try {
                findGuardPattern(row, endStart, END_PATTERN_REVERSED[0])
            } catch (_: NotFoundException) {
                findGuardPattern(row, endStart, END_PATTERN_REVERSED[1])
            }
            validateQuietZone(row, endPattern[0])

            let temp = endPattern[0]
            endPattern[0] = row.size - endPattern[1]
            endPattern[1] = row.size - temp

            endPattern
        } finally {
            row.reverse()
        }
    }
