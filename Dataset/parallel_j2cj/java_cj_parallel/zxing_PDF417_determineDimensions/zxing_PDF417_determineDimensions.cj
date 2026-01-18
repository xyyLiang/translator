    func determineDimensions(sourceCodeWords: Int64, errorCorrectionCodeWords: Int64): Array<Int64> {
        var ratio = 0.0
        var dimension: ?Array<Int64> = None

        for (cols in minCols..=maxCols) {
            let rows = calculateNumberOfRows(sourceCodeWords, errorCorrectionCodeWords, cols)

            if (rows < minRows) {
                break
            }

            if (rows > maxRows) {
                continue
            }

            let newRatio = (Float64(17 * cols + 69) * DEFAULT_MODULE_WIDTH) / (Float64(rows) * HEIGHT)

            if (if (let None = dimension) {
                false
            } else {
                true
            } && math.abs(newRatio - PREFERRED_RATIO) > math.abs(ratio - PREFERRED_RATIO)) {
                continue
            }

            ratio = newRatio
            dimension = [cols, rows]
        }

        if (let None = dimension) {
            let rows = calculateNumberOfRows(sourceCodeWords, errorCorrectionCodeWords, minCols)
            if (rows < minRows) {
                dimension = [minCols, minRows]
            }
        }

        if (let Some(d) = dimension) {
            d
        } else {
            throw WriterException("Unable to fit message in columns")
        }
    }