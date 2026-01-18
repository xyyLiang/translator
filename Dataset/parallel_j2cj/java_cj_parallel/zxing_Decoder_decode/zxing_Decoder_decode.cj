    public func decode(detectorResult: AztecDetectorResult): DecoderResult {
        this.ddata = detectorResult
        let rawbits = extractBits(detectorResult.bits)
        let correctedBits = correctBits(rawbits)
        let rawBytes = convertBoolArrayToByteArray(correctedBits.correctBits)
        let result = getEncodedData(correctedBits.correctBits)
        let decoderResult = DecoderResult(rawBytes, result, None, "${correctedBits.ecLevel}")
        decoderResult.numBits = correctedBits.correctBits.size
        decoderResult
    }