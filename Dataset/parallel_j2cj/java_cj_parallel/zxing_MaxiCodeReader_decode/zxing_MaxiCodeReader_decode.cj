    public func decode(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>): Result {
        let bits = extractPureBits(image.binarizer.blackMatrix())
        let decoderResult = decoder.decode(bits, hints)
        let result = Result(decoderResult.text, decoderResult.rawBytes, NO_POINTS, BarcodeFormat.MAXICODE)
        if (let Some(ecLevel) = decoderResult.ecLevel) {
            result.putMetadata(ResultMetadataType.ERROR_CORRECTION_LEVEL, ecLevel)
        }
        result
    }