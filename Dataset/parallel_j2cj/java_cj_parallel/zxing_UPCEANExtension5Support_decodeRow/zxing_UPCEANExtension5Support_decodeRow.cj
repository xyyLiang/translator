    func decodeRow(rowNumber: Int64, row: BitArray, extensionStartRange: Array<Int64>): Result {
        let result = decodeRowStringBuffer
        result.clear()
        let end = decodeMiddle(row, extensionStartRange, result)

        let resultString = result.toString()
        let extensionData = parseExtensionString(resultString)

        let extensionResult = Result(
            resultString,
            None,
            [
                ResultPoint(Float64(extensionStartRange[0] + extensionStartRange[1]) / 2.0, Float64(rowNumber)),
                ResultPoint(Float64(end), Float64(rowNumber))
            ],
            BarcodeFormat.UPC_EAN_EXTENSION
        )
        if (let Some(e) = extensionData) {
            extensionResult.putAllMetadata(e)
        }
        extensionResult
    }