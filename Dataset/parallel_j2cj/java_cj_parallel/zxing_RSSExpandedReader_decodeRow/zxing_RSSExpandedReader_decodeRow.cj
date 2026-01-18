    public func decodeRow(rowNumber: Int64, row: BitArray, hints: ?HashMap<DecodeHintType, Any>): Result {
        this.pairs.clear()
        this.startFromEven = false
        try {
            return constructResult(decodeRow2pairs(rowNumber, row))
        } catch (e: NotFoundException) {}
        this.pairs.clear()
        this.startFromEven = true
        constructResult(decodeRow2pairs(rowNumber, row))
    }
