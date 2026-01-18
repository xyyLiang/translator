    static func findVertices(matrix: BitMatrix, ostartRow: Int64, ostartColumn: Int64): Array<?ResultPoint> {
        let height = matrix.height
        let width = matrix.width
        var startColumn = ostartColumn
        var startRow = ostartRow

        let result = Array<?ResultPoint>(8, {n => None})
        copyToResult(
            result,
            findRowsWithPattern(matrix, height, width, startRow, startColumn, START_PATTERN),
            INDEXES_START_PATTERN
        )

        if (let Some(v) = result[4]) {
            startColumn = Int64(v.x)
            startRow = Int64(v.y)
        }
        copyToResult(
            result,
            findRowsWithPattern(matrix, height, width, startRow, startColumn, STOP_PATTERN),
            INDEXES_STOP_PATTERN
        )
        result
    }