    static func findRowsWithPattern(
        matrix: BitMatrix,
        height: Int64,
        width: Int64,
        ostartRow: Int64,
        startColumn: Int64,
        pattern: Array<Int64>
    ): Array<?ResultPoint> {
        let result = Array<?ResultPoint>(4, {n => None})
        var found = false
        let counters = Array<Int64>(pattern.size, item: 0)
        var startRow = ostartRow
        while (startRow < height) {
            if (let Some(loc) = findGuardPattern(matrix, startColumn, startRow, width, pattern, counters)) {
                var nloc = loc
                while (startRow > 0) {
                    startRow--
                    if (let Some(previousRowLoc) = findGuardPattern(
                        matrix,
                        startColumn,
                        startRow,
                        width,
                        pattern,
                        counters
                    )) {
                        nloc = previousRowLoc
                    } else {
                        startRow++
                        break
                    }
                }
                result[0] = ResultPoint(nloc[0], startRow)
                result[1] = ResultPoint(nloc[1], startRow)
                found = true
                break
            }

            startRow += ROW_STEP
        }
        var stopRow = startRow + 1
        if (found) {
            var skippedRowCount = 0
            var previousRowLoc: Array<Int64> = [Int64(result[0].getOrThrow().x), Int64(result[1].getOrThrow().x)]
            while (stopRow < height) {
                if (let Some(loc) = findGuardPattern(matrix, previousRowLoc[0], stopRow, width, pattern, counters)) {
                    if (math.abs(previousRowLoc[0] - loc[0]) < MAX_PATTERN_DRIFT &&
                        math.abs(previousRowLoc[1] - loc[1]) < MAX_PATTERN_DRIFT) {
                        previousRowLoc = loc
                        skippedRowCount = 0
                    }
                } else {
                    if (skippedRowCount > SKIPPED_ROW_COUNT_MAX) {
                        break
                    } else {
                        skippedRowCount++
                    }
                }
                stopRow++
            }
            stopRow -= skippedRowCount + 1
            result[2] = ResultPoint(previousRowLoc[0], stopRow)
            result[3] = ResultPoint(previousRowLoc[1], stopRow)
        }
        if (stopRow - startRow < BARCODE_MIN_HEIGHT) {
            for (i in 0..result.size) {
                result[i] = None
            }
        }
        result
    }
