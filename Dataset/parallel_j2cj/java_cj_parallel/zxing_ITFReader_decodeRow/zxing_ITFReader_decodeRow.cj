    public override func decodeRow(rowNumber: Int64, row: BitArray, hints: ?HashMap<DecodeHintType, Any>): Result {
        let startRange = decodeStart(row)
        let endRange = decodeEnd(row)

        let result = StringBuilder()
        decodeMiddle(row, startRange[1], endRange[0], result)
        let resultString = result.toString()

        var allowedLengths: Array<Int64> = if (let Some(h) = hints) {
            if (let Some(a) = h.get(DecodeHintType.ALLOWED_LENGTHS)) {
                if (let Some(b) = (a as Array<Int64>)) {
                    b
                } else {
                    DEFAULT_ALLOWED_LENGTHS
                }
            } else {
                DEFAULT_ALLOWED_LENGTHS
            }
        } else {
            DEFAULT_ALLOWED_LENGTHS
        }

        let length = resultString.size
        var lengthOK = false
        var maxAllowedLength = 0
        for (allowedLength in allowedLengths) {
            if (length == allowedLength) {
                lengthOK = true
                break
            }
            if (allowedLength > maxAllowedLength) {
                maxAllowedLength = allowedLength
            }
        }
        if (!lengthOK && length > maxAllowedLength) {
            lengthOK = true
        }
        if (!lengthOK) {
            throw FormatException()
        }

        let resultObject = Result(
            resultString,
            None,
            [
                ResultPoint(Float64(startRange[1]), Float64(rowNumber)),
                ResultPoint(Float64(endRange[0]), Float64(rowNumber))
            ],
            BarcodeFormat.ITF
        )
        resultObject.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]I0")
        resultObject
    }