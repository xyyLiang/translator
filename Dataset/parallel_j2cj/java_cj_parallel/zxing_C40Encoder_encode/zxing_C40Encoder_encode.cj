    public open func encode(context: EncoderContext): Unit {
        let buffer = StringBuilder()
        while (context.hasMoreCharacters()) {
            let c = context.getCurrent()
            context.pos++

            var lastCharSize = encodeChar(c, buffer)

            let unwritten = (buffer.size / 3) * 2

            let curCodewordCount = context.getCodewordCount() + unwritten
            context.updateSymbolInfo(curCodewordCount)
            let available = context.symbolInfo.getOrThrow().dataCapacity - curCodewordCount

            if (!context.hasMoreCharacters()) {
                let removed = StringBuilder()
                if ((buffer.size % 3) == 2 && available != 2) {
                    lastCharSize = backtrackOneCharacter(context, buffer, removed, lastCharSize)
                }
                while ((buffer.size % 3) == 1 && (lastCharSize > 3 || available != 1)) {
                    lastCharSize = backtrackOneCharacter(context, buffer, removed, lastCharSize)
                }
                break
            }

            let count = buffer.size
            if ((count % 3) == 0) {
                let newMode = HighLevelEncoder.lookAheadTest(context.msg, context.pos, getEncodingMode())
                if (newMode != getEncodingMode()) {
                    context.newEncoding = HighLevelEncoder.ASCII_ENCODATION
                    break
                }
            }
        }
        handleEOD(context, buffer)
    }