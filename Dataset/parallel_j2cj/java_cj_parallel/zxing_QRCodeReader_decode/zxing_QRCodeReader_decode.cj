    public func decode(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>): Result {
        let (decoderResult, points): (DecoderResult, Array<ResultPoint>) = if (let Some(h) = hints) {
            if (h.contains(DecodeHintType.PURE_BARCODE)) {
                (decoder.decode(extractPureBits(image.matrix), h), Array<ResultPoint>())
            } else {
                let detectorResult = Detector(image.matrix).detect(h)
                (decoder.decode(detectorResult.bits, h), detectorResult.points)
            }
        } else {
            let detectorResult = Detector(image.matrix).detect(hints)
            (decoder.decode(detectorResult.bits, hints), detectorResult.points)
        }
        if (decoderResult.other is QRCodeDecoderMetaData) {
            (decoderResult.other as QRCodeDecoderMetaData).getOrThrow().applyMirroredCorrection(points)
        }
        let result = Result(decoderResult.text, decoderResult.rawBytes, points, BarcodeFormat.QR_CODE)
        let byteSegments = decoderResult.byteSegments
        if (let Some(b) = byteSegments) {
            result.putMetadata(ResultMetadataType.BYTE_SEGMENTS, b)
        }
        let ecLevel = decoderResult.ecLevel
        if (let Some(e) = ecLevel) {
            result.putMetadata(ResultMetadataType.ERROR_CORRECTION_LEVEL, e)
        }
        if (decoderResult.hasStructuredAppend()) {
            result.putMetadata(
                ResultMetadataType.STRUCTURED_APPEND_SEQUENCE,
                decoderResult.structuredAppendSequenceNumber
            )
            result.putMetadata(
                ResultMetadataType.STRUCTURED_APPEND_PARITY,
                decoderResult.structuredAppendParity
            )
        }
        result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]Q${decoderResult.symbologyModifier}")
        result
    }