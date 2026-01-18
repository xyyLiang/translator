    public func decode(bits: BitMatrix, hints: ?HashMap<DecodeHintType, Any>): DecoderResult {
        let parser = BitMatrixParser(bits)
        var fe: ?FormatException = None
        var ce: ?ChecksumException = None
        try {
            return decode(parser, hints)
        } catch (e: FormatException) {
            fe = e
        } catch (e: ChecksumException) {
            ce = e
        }
        try {
            parser.remask()
            parser.setMirror(true)
            parser.readVersion()
            parser.readFormatInformation()
            parser.doMirror()

            let result = decode(parser, hints)
            result.other = QRCodeDecoderMetaData(true)
            return result
        } catch (e: FormatException | ChecksumException) {
            if (let Some(f) = fe) {
                throw f
            }
            if (let Some(f) = ce) {
                throw f
            }
            throw e
        }
    }