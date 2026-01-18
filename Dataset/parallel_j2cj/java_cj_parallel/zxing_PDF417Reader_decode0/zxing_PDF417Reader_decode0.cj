    static func decode0(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>, multiple: Bool): Array<Result> {
        let results = ArrayList<Result>()
        let detectorResult = Detector.detect(image, hints, multiple)
        for (points in detectorResult.points) {
            let decoderResult = PDF417ScanningDecoder.decode(
                detectorResult.bits,
                points[4],
                points[5],
                points[6],
                points[7],
                getMinCodewordWidth(points),
                getMaxCodewordWidth(points)
            )
            if (let Some(dr) = decoderResult) {
                let ps = Array<ResultPoint>(points.size, {
                        n => points[n] ?? ResultPoint(0, 0)
                    })
                let result = Result(
                    dr.text,
                    dr.rawBytes,
                    ps,
                    BarcodeFormat.PDF_417
                )
                result.putMetadata(ResultMetadataType.ERROR_CORRECTION_LEVEL, dr.ecLevel)
                if (let Some(pdf417ResultMetadata) = dr.other) {
                    result.putMetadata(ResultMetadataType.PDF417_EXTRA_METADATA, pdf417ResultMetadata)
                }
                result.putMetadata(ResultMetadataType.ORIENTATION, detectorResult.rotation)
                result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]L${dr.symbologyModifier}")
                results.append(result)
            }
        }
        results.toArray()
    }