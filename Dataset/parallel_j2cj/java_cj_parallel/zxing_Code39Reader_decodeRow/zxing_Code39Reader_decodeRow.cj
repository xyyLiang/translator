    public override func decodeRow(rowNumber: Int64, row: BitArray, hints: ?HashMap<DecodeHintType, Any>): Result {
        let theCounters = counters
        for (i in 0..theCounters.size) {
            theCounters[i] = 0
        }
        let result = decodeRowResult
        result.clear()

        let start = findAsteriskPattern(row, theCounters)
        var nextStart = row.nextSet(start[1])
        let end = row.size

        var decodedChar = '\0'
        var lastStart = 0
        do {
            recordPattern(row, nextStart, theCounters)
            let pattern = toNarrowWidePattern(theCounters)
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
        let whiteSpaceAfterEnd = nextStart - lastStart - lastPatternSize
        if (nextStart != end && (whiteSpaceAfterEnd * 2) < lastPatternSize) {
            throw NotFoundException()
        }

        if (usingCheckDigit) {
            let max = result.size - 1
            var total = 0
            for (i in 0..max) {
                total += if (let Some(idx) = ALPHABET_STRING.indexOf(decodeRowResult.get(i).getOrThrow())) {
                    idx
                } else {
                    -1
                }
            }
            if (result.get(max).getOrThrow() != ALPHABET_STRING.charAt(total % 43)) {
                throw ChecksumException()
            }
            result.removeLast()
        }

        if (result.size == 0) {
            throw NotFoundException()
        }

        let resultString = if (extendedMode) {
            decodeExtended(result.toString())
        } else {
            result.toString()
        }

        let left = Float64(start[1] + start[0]) / 2.0
        let right = Float64(lastStart) + Float64(lastPatternSize) / 2.0

        let resultObject = Result(
            resultString,
            None,
            [
                ResultPoint(left, Float64(rowNumber)),
                ResultPoint(right, Float64(rowNumber))
            ],
            BarcodeFormat.CODE_39
        )
        resultObject.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]A0")
        resultObject
    }