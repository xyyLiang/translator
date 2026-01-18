    func decodeStart(row: BitArray): Array<Int64> {
        let endStart = skipWhiteSpace(row)
        let startPattern = findGuardPattern(row, endStart, START_PATTERN)

        this.narrowLineWidth = (startPattern[1] - startPattern[0]) / 4

        validateQuietZone(row, startPattern[0])

        startPattern
    }