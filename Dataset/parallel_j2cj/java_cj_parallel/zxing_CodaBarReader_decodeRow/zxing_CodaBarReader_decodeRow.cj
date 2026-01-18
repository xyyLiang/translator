    public func decodeRow(rowNumber: Int64, row: BitArray, hints: ?HashMap<DecodeHintType, Any>): Result {
        for (i in 0..counters.size) {
            counters[i] = 0
        }
        setCounters(row)
        let startOffset = findStartPattern()
        var nextStart = startOffset
        decodeRowResult.clear()
        do {
            let charOffset = toNarrowWidePattern(nextStart)
            if (charOffset == -1) {
                throw NotFoundException()
            }
            decodeRowResult.append(Char(UInt32(charOffset)))
            nextStart += 8
            if (decodeRowResult.size > 1 && arrayContains(STARTEND_ENCODING, ALPHABET[charOffset])) {
                break
            }
        } while (nextStart < counterLength)
        
        let trailingWhitespace = counters[nextStart - 1]
        var lastPatternSize = 0
        for (i in -8..-1) {
            lastPatternSize += counters[nextStart + i]
        }

        if (nextStart < counterLength && trailingWhitespace < lastPatternSize / 2) {
            throw NotFoundException()
        }

        validatePattern(startOffset)

        for (i in 0..decodeRowResult.size) {
            let c = ALPHABET[Int64(UInt32(decodeRowResult.get(i).getOrThrow()))]
            decodeRowResult.remove(i)
            decodeRowResult.insert(i, c)
        }
        let startchar = decodeRowResult.get(0).getOrThrow()
        if (!arrayContains(STARTEND_ENCODING, startchar)) {
            throw NotFoundException()
        }
        let endchar = decodeRowResult.get(decodeRowResult.size - 1).getOrThrow()
        if (!arrayContains(STARTEND_ENCODING, endchar)) {
            throw NotFoundException()
        }

        if (decodeRowResult.size <= MIN_CHARACTER_LENGTH) {
            throw NotFoundException()
        }

        if (let Some(h) = hints) {
            if (!h.contains(DecodeHintType.RETURN_CODABAR_START_END)) {
                decodeRowResult.remove(decodeRowResult.size - 1)
                decodeRowResult.remove(0)
            }
        } else {
            decodeRowResult.remove(decodeRowResult.size - 1)
            decodeRowResult.remove(0)
        }

        var runningCount = 0
        for (i in 0..startOffset) {
            runningCount += counters[i]
        }
        var left = runningCount
        for (i in startOffset..(nextStart - 1)) {
            runningCount += counters[i]
        }
        var right = runningCount
        let result = Result(
            decodeRowResult.toString(),
            None,
            [ResultPoint(Float64(left), Float64(rowNumber)), ResultPoint(Float64(right), Float64(rowNumber))],
            BarcodeFormat.CODABAR
        )
        result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]F0")
        result
    }