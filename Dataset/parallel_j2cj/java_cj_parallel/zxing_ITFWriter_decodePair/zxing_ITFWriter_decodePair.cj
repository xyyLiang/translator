    func decodePair(row: BitArray, right: Bool, rowNumber: Int64, hints: ?HashMap<DecodeHintType, Any>): ?Pair {
        try {
            var startEnd = findFinderPattern(row, right)
            let pattern = parseFoundFinderPattern(row, rowNumber, right, startEnd)

            let resultPointCallback: ?ResultPointCallback = if (let Some(h) = hints) {
                if (let Some(r) = h.get(DecodeHintType.NEED_RESULT_POINT_CALLBACK)) {
                    r as ResultPointCallback
                } else {
                    None
                }
            } else {
                None
            }

            if (let Some(r) = resultPointCallback) {
                startEnd = pattern.startEnd
                var center = Float64(startEnd[0] + startEnd[1] - 1) / 2.0
                if (right) {
                    center = Float64(row.size) - 1.0 - center
                }
                r.foundPossibleResultPoint(ResultPoint(center, Float64(rowNumber)))
            }

            let outside = decodeDataCharacter(row, pattern, true)
            let inside = decodeDataCharacter(row, pattern, false)
            Pair(
                1597 * outside.value + inside.value,
                outside.checksumPortion + 4 * inside.checksumPortion,
                pattern
            )
        } catch (_: NotFoundException) {
            None
        }
    }
