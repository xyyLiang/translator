    func decodeRow(rowNumber: Int64, row: BitArray, rowOffset: Int64): Result {
        let extensionStartRange = UPCEANReader.findGuardPattern(row, rowOffset, false, EXTENSION_START_PATTERN)
        try {
            fiveSupport.decodeRow(rowNumber, row, extensionStartRange)
        } catch (_: ReaderException) {
            twoSupport.decodeRow(rowNumber, row, extensionStartRange)
        }
    }