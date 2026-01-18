    static func constructResult(pairs: ArrayList<ExpandedPair>): Result {
        let binary = buildBitArray(pairs)

        let decoder = AbsRSSExpandedReader.createDecoder(binary)
        let resultingString = decoder.parseInformation()

        let firstPoints: Array<ResultPoint> = pairs[0].finderPattern.getOrThrow().resultPoints
        let lastPoints: Array<ResultPoint> = pairs[pairs.size - 1].finderPattern.getOrThrow().resultPoints

        let result = Result(
            resultingString,
            None,
            [firstPoints[0], firstPoints[1], lastPoints[0], lastPoints[1]],
            BarcodeFormat.RSS_EXPANDED
        )
        result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]e0")
        result
    }