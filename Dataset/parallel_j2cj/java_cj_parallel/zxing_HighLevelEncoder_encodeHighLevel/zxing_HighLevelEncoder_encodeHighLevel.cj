    static func encodeHighLevel(
        msg: String,
        shape: SymbolShapeHint,
        minSize: ?Dimension,
        maxSize: ?Dimension,
        forceC40: Bool
    ): String {
        let c40Encoder = C40Encoder()
        let encoders: Array<Encoder> = [
            ASCIIEncoder(),
            c40Encoder,
            TextEncoder(),
            X12Encoder(),
            EdifactEncoder(),
            Base256Encoder()
        ]

        let context = EncoderContext(msg)
        context.shape = shape
        context.setSizeConstraints(minSize, maxSize)

        if (msg.startsWith(MACRO_05_HEADER) && msg.endsWith(MACRO_TRAILER)) {
            context.writeCodeword(MACRO_05)
            context.setSkipAtEnd(2)
            context.pos += MACRO_05_HEADER.size
        } else if (msg.startsWith(MACRO_06_HEADER) && msg.endsWith(MACRO_TRAILER)) {
            context.writeCodeword(MACRO_06)
            context.setSkipAtEnd(2)
            context.pos += MACRO_06_HEADER.size
        }
        var encodingMode = ASCII_ENCODATION

        if (forceC40) {
            c40Encoder.encodeMaximal(context)
            encodingMode = context.newEncoding
            context.resetEncoderSignal()
        }

        while (context.hasMoreCharacters()) {
            encoders[encodingMode].encode(context)
            if (context.newEncoding >= 0) {
                encodingMode = context.newEncoding
                context.resetEncoderSignal()
            }
        }
        let len = context.getCodewordCount()
        context.updateSymbolInfo()
        let capacity = context.symbolInfo.getOrThrow().dataCapacity
        if (len < capacity && encodingMode != ASCII_ENCODATION && encodingMode != BASE256_ENCODATION && encodingMode !=
            EDIFACT_ENCODATION) {
            context.writeCodeword('\u{00fe}')
        }

        let codewords = context.codewords
        if (codewords.size < capacity) {
            codewords.append(PAD)
        }
        while (codewords.size < capacity) {
            codewords.append(randomize253State(codewords.size + 1))
        }
        context.codewords.toString()
    }
