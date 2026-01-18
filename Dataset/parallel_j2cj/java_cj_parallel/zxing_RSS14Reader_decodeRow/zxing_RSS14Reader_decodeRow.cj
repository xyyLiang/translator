    public override func decodeRow(rowNumber: Int64, row: BitArray, hints: ?HashMap<DecodeHintType, Any>): Result {
        let leftPair = decodePair(row, false, rowNumber, hints)
        addOrTally(possibleLeftPairs, leftPair)
        row.reverse()
        let rightPair = decodePair(row, true, rowNumber, hints)
        addOrTally(possibleRightPairs, rightPair)
        row.reverse()
        for (left in possibleLeftPairs) {
            if (left.count > 1) {
                for (right in possibleRightPairs) {
                    if (right.count > 1 && checkChecksum(left, right)) {
                        return constructResult(left, right)
                    }
                }
            }
        }
        throw NotFoundException()
    }
