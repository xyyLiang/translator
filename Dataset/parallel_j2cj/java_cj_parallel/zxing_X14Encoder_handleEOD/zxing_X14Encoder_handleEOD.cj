    override func handleEOD(context: EncoderContext, buffer: StringBuilder) {
        context.updateSymbolInfo()
        let available = context.symbolInfo.getOrThrow().dataCapacity - context.getCodewordCount()
        let count = buffer.size
        context.pos -= count
        if (context.getRemainingCharacters() > 1 || available > 1 || context.getRemainingCharacters() != available) {
            context.writeCodeword(HighLevelEncoder.X12_UNLATCH)
        }
        if (context.newEncoding < 0) {
            context.newEncoding = HighLevelEncoder.ASCII_ENCODATION
        }
    }