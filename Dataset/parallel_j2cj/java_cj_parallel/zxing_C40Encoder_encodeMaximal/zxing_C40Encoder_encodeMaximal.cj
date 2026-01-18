    func encodeMaximal(context: EncoderContext) {
        let buffer = StringBuilder()
        var lastCharSize = 0
        var backtrackStartPosition = context.pos
        var backtrackBufferLength = 0
        while (context.hasMoreCharacters()) {
            let c = context.getCurrent()
            context.pos++
            lastCharSize = encodeChar(c, buffer)
            if (buffer.size % 3 == 0) {
                backtrackStartPosition = context.pos
                backtrackBufferLength = buffer.size
            }
        }
        if (backtrackBufferLength != buffer.size) {
            let unwritten = (buffer.size / 3) * 2

            let curCodewordCount = context.getCodewordCount() + unwritten + 1
            context.updateSymbolInfo(curCodewordCount)
            let available = context.symbolInfo.getOrThrow().dataCapacity - curCodewordCount
            let rest = buffer.size % 3
            if ((rest == 2 && available != 2) || (rest == 1 && (lastCharSize > 3 || available != 1))) {
                buffer.remove(backtrackBufferLength..buffer.size)
                context.pos = backtrackStartPosition
            }
        }
        if (buffer.size > 0) {
            context.writeCodeword(HighLevelEncoder.LATCH_TO_C40)
        }
        handleEOD(context, buffer)
    }