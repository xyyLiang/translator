    public func decode(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>): Result {
        let (decoderResult, points) = if (let Some(h) = hints) {
            if (h.contains(DecodeHintType.PURE_BARCODE)) {
                let bits = extractPureBits(image.binarizer.blackMatrix())
                (decoder.decode(bits), Array<ResultPoint>())
            } else {
                let detectorResult = Detector(image.binarizer.blackMatrix()).detect()
                (decoder.decode(detectorResult.bits), detectorResult.points)
            }
        } else {
            let detectorResult = Detector(image.binarizer.blackMatrix()).detect()
            (decoder.decode(detectorResult.bits), detectorResult.points)
        }
        let result = Result(decoderResult.text, decoderResult.rawBytes, points, BarcodeFormat.DATA_MATRIX)
        if (let Some(byteSegments) = decoderResult.byteSegments) {
            result.putMetadata(ResultMetadataType.BYTE_SEGMENTS, byteSegments)
        }
        if (let Some(ecLevel) = decoderResult.ecLevel) {
            result.putMetadata(ResultMetadataType.ERROR_CORRECTION_LEVEL, ecLevel)
        }
        result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]d${decoderResult.symbologyModifier}")
        result
    }