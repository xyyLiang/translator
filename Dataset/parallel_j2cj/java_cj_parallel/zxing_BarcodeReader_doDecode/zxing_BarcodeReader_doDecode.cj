    func doDecode(image: BinaryBitmap, oHints: ?HashMap<DecodeHintType, Any>): Result {
        let (width, height) = (image.binarizer.source.width, image.binarizer.source.height)
        var row = BitArray(width)

        var hints = oHints
        let tryHarder = if (let Some(h) = hints) {
            h.contains(DecodeHintType.TRY_HARDER)
        } else {
            false
        }
        let rowStep = math.max(1, height >> (if (tryHarder) {
                8
            } else {
                5
            }))
        let maxLines = if (tryHarder) {
            height
        } else {
            15
        }

        let middle = height / 2
        let fwidth = Float64(width)
        for (x in 0..maxLines) {
            let rowStepsAboveOrBelow = (x + 1) / 2
            let isAbove = (x & 0x01) == 0
            let rowNumber = middle + rowStep * (if (isAbove) {
                rowStepsAboveOrBelow
            } else {
                -rowStepsAboveOrBelow
            })
            if (rowNumber < 0 || rowNumber >= height) {
                break
            }
            try {
                row = image.binarizer.blackRow(rowNumber, row)
            } catch (_: NotFoundException) {
                continue
            }
            for (attempt in 0..2) {
                if (attempt == 1) {
                    row.reverse()
                    if (let Some(h) = hints) {
                        if (h.contains(DecodeHintType.NEED_RESULT_POINT_CALLBACK)) {}
                        let newHints = HashMap<DecodeHintType, Any>(h)
                        newHints.remove(DecodeHintType.NEED_RESULT_POINT_CALLBACK)
                        hints = newHints
                    }
                }
                try {
                    let result = decodeRow(rowNumber, row, hints)
                    if (attempt == 1) {
                        result.putMetadata(ResultMetadataType.ORIENTATION, 180)
                        if (let Some(p) = result.resultPoints) {
                            p[0] = ResultPoint(fwidth - p[0].x - 1.0, p[0].y)
                            p[1] = ResultPoint(fwidth - p[1].x - 1.0, p[1].y)
                        }
                    }
                    return result
                } catch (_: ReaderException) {}
            }
        }

        throw NotFoundException()
    }