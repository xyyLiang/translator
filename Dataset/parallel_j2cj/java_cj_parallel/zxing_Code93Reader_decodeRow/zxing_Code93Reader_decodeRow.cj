    public func decodeRow(rowNumber: Int64, row: BitArray, hints: ?HashMap<DecodeHintType, Any>): Result {
        let start = findAsteriskPattern(row)
        var nextStart = row.nextSet(start[1])
        let end = row.size

        let theCounters = counters
        for (i in 0..theCounters.size) {
            theCounters[i] = 0
        }
        let result = decodeRowResult
        result.clear()

        var decodedChar = '\0'
        var lastStart = 0
        do {
            recordPattern(row, nextStart, theCounters)
            let pattern = toPattern(theCounters)
            if (pattern < 0) {
                throw NotFoundException()
            }
            decodedChar = patternToChar(pattern)
            result.append(decodedChar)
            lastStart = nextStart
            for (counter in theCounters) {
                nextStart += counter
            }
            nextStart = row.nextSet(nextStart)
        } while (decodedChar != '*')
        result.removeLast()

        var lastPatternSize = 0
        for (counter in theCounters) {
            lastPatternSize += counter
        }

        if (nextStart == end || !row.get(nextStart)) {
            throw NotFoundException()
        }

        if (result.size < 2) {
            throw NotFoundException()
        }

        checkChecksums(result.toString())
        result.remove((result.size - 2)..result.size)

        let resultString = decodeExtended(result.toString())

        let left = Float64(start[1] + start[0]) / 2.0
        let right = Float64(lastStart) + Float64(lastPatternSize) / 2.0

        let resultObject = Result(
            resultString,
            None,
            [
                ResultPoint(left, Float64(rowNumber)),
                ResultPoint(right, Float64(rowNumber))
            ],
            BarcodeFormat.CODE_93
        )
        resultObject.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]G0")
        resultObject
    }