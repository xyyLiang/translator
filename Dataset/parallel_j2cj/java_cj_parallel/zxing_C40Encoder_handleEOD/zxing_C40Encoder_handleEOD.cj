    open func handleEOD(context: EncoderContext, buffer: StringBuilder) {
        let unwritten = (buffer.size / 3) * 2
        let rest = buffer.size % 3

        let curCodewordCount = context.getCodewordCount() + unwritten
        context.updateSymbolInfo(curCodewordCount)
        let available = context.symbolInfo.getOrThrow().dataCapacity - curCodewordCount

        if (rest == 2) {
            buffer.append('\0')
            while (buffer.size >= 3) {
                writeNextTriplet(context, buffer)
            }
            if (context.hasMoreCharacters()) {
                context.writeCodeword(HighLevelEncoder.C40_UNLATCH)
            }
        } else if (available == 1 && rest == 1) {
            while (buffer.size >= 3) {
                writeNextTriplet(context, buffer)
            }
            if (context.hasMoreCharacters()) {
                context.writeCodeword(HighLevelEncoder.C40_UNLATCH)
            }

            context.pos--
        } else if (rest == 0) {
            while (buffer.size >= 3) {
                writeNextTriplet(context, buffer)
            }
            if (available > 0 || context.hasMoreCharacters()) {
                context.writeCodeword(HighLevelEncoder.C40_UNLATCH)
            }
        } else {
            throw IllegalArgumentException("Unexpected case. Please report!")
        }
        context.newEncoding = HighLevelEncoder.ASCII_ENCODATION
    }