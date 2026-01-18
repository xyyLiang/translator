    public func decode(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>): Result {
        var notFoundException: ?NotFoundException = None
        var formatException: ?FormatException = None
        let detector = Detector(image.binarizer.blackMatrix())
        var points: ?Array<ResultPoint> = None
        var decoderResult: ?DecoderResult = None

        try {
            let detectorResult = detector.detect(false)
            points = detectorResult.points
            decoderResult = Decoder().decode(detectorResult)
        } catch (e: NotFoundException) {
            notFoundException = e
        } catch (e: FormatException) {
            formatException = e
        }
        if (let None = decoderResult) {
            try {
                let detectorResult = detector.detect(true)
                points = detectorResult.points
                decoderResult = Decoder().decode(detectorResult)
            } catch (e: NotFoundException) {
                throwable(e, notFoundException, formatException)
            } catch (e: FormatException) {
                throwable(e, notFoundException, formatException)
            }
        }

        if (let Some(h) = hints) {
            let rpcb = h[DecodeHintType.NEED_RESULT_POINT_CALLBACK] as ResultPointCallback
            if (let Some(cb) = rpcb) {
                for (point in points.getOrThrow()) {
                    cb.foundPossibleResultPoint(point)
                }
            }
        }

        let dr = decoderResult.getOrThrow()

        let result = Result(
            dr.text,
            dr.rawBytes,
            dr.numBits,
            points,
            BarcodeFormat.AZTEC,
            Time.now().unixTimeStamp().milliseconds()
        )

        let byteSegments = dr.byteSegments
        if (let Some(b) = byteSegments) {
            result.putMetadata(ResultMetadataType.BYTE_SEGMENTS, b)
        }
        let ecLevel = dr.ecLevel
        if (let Some(ec) = ecLevel) {
            result.putMetadata(ResultMetadataType.ERROR_CORRECTION_LEVEL, ec)
        }
        result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]z${dr.symbologyModifier}")

        result
    }