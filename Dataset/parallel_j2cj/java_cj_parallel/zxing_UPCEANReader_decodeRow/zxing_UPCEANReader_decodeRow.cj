    public open func decodeRow(
        rowNumber: Int64,
        row: BitArray,
        startGuardRange: Array<Int64>,
        hints: ?HashMap<DecodeHintType, Any>
    ): Result {
        let resultPointCallback: ?ResultPointCallback = if (let Some(h) = hints) {
            if (let Some(r) = h.get(DecodeHintType.NEED_RESULT_POINT_CALLBACK)) {
                r as ResultPointCallback
            } else {
                None
            }
        } else {
            None
        }

        var symbologyIdentifier = 0

        if (let Some(r) = resultPointCallback) {
            r.foundPossibleResultPoint(
                ResultPoint(Float64(startGuardRange[0] + startGuardRange[1]) / 2.0, Float64(rowNumber)))
        }

        let result = decodeRowStringBuffer
        result.clear()

        let endStart = decodeMiddle(row, startGuardRange, result)
        if (let Some(r) = resultPointCallback) {
            r.foundPossibleResultPoint(ResultPoint(Float64(endStart), Float64(rowNumber)))
        }

        let endRange = decodeEnd(row, endStart)
        if (let Some(r) = resultPointCallback) {
            r.foundPossibleResultPoint(ResultPoint(Float64(endRange[0] + endRange[1]) / 2.0, Float64(rowNumber)))
        }

        let end = endRange[1]
        let quietEnd = end + (end - endRange[0])
        if (quietEnd >= row.size || !row.isRange(end, quietEnd, false)) {
            throw NotFoundException()
        }

        let resultString = result.toString()
        if (resultString.size < 8) {
            throw FormatException()
        }
        if (!checkChecksum(resultString)) {
            throw ChecksumException()
        }

        let left = Float64(startGuardRange[1] + startGuardRange[0]) / 2.0
        let right = Float64(endRange[1] + endRange[0]) / 2.0
        let format = getBarcodeFormat()
        let decodeResult = Result(
            resultString,
            None,
            [
                ResultPoint(left, Float64(rowNumber)),
                ResultPoint(right, Float64(rowNumber))
            ],
            format
        )

        var extensionLength = 0

        try {
            let extensionResult = extensionReader.decodeRow(rowNumber, row, endRange[1])
            decodeResult.putMetadata(ResultMetadataType.UPC_EAN_EXTENSION, extensionResult.text)
            decodeResult.putAllMetadata(extensionResult.resultMetadata)
            decodeResult.addResultPoints(extensionResult.resultPoints)
            extensionLength = extensionResult.text.size
        } catch (_: ReaderException) {}
        let allowedExtensions: ?Array<Int64> = if (let Some(h) = hints) {
            if (let Some(a) = h.get(DecodeHintType.ALLOWED_EAN_EXTENSIONS)) {
                a as Array<Int64>
            } else {
                None
            }
        } else {
            None
        }
        if (let Some(a) = allowedExtensions) {
            var valid = false
            for (length in a) {
                if (extensionLength == length) {
                    valid = true
                    break
                }
            }
            if (!valid) {
                throw NotFoundException()
            }
        }

        if (format == BarcodeFormat.EAN_13 || format == BarcodeFormat.UPC_A) {
            let countryID = eanManSupport.lookupCountryIdentifier(resultString)
            if (let Some(c) = countryID) {
                decodeResult.putMetadata(ResultMetadataType.POSSIBLE_COUNTRY, c)
            }
        }
        if (format == BarcodeFormat.EAN_8) {
            symbologyIdentifier = 4
        }

        decodeResult.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]E${symbologyIdentifier}")
        decodeResult
    }