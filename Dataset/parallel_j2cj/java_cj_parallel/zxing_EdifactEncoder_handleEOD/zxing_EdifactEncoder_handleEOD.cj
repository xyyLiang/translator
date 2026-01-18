    func handleEOD(context: EncoderContext, buffer: StringBuilder) {
        try {
            let count = buffer.size
            if (count == 0) {
                return
            }
            if (count == 1) {
                context.updateSymbolInfo()
                var available = context.symbolInfo.getOrThrow().dataCapacity - context.getCodewordCount()
                let remaining = context.getRemainingCharacters()

                if (remaining > available) {
                    context.updateSymbolInfo(context.getCodewordCount() + 1)
                    available = context.symbolInfo.getOrThrow().dataCapacity - context.getCodewordCount()
                }
                if (remaining <= available && available <= 2) {
                    return
                }
            }

            if (count > 4) {
                throw IllegalArgumentException("Count must not exceed 4")
            }
            let restChars = count - 1
            let encoded = encodeToCodewords(buffer)
            let endOfSymbolReached = !context.hasMoreCharacters()
            var restInAscii = endOfSymbolReached && restChars <= 2

            if (restChars <= 2) {
                context.updateSymbolInfo(context.getCodewordCount() + restChars)
                let available = context.symbolInfo.getOrThrow().dataCapacity - context.getCodewordCount()
                if (available >= 3) {
                    restInAscii = false
                    context.updateSymbolInfo(context.getCodewordCount() + encoded.size)
                }
            }

            if (restInAscii) {
                context.resetSymbolInfo()
                context.pos -= restChars
            } else {
                context.writeCodewords(encoded)
            }
        } finally {
            context.newEncoding = HighLevelEncoder.ASCII_ENCODATION
        }
    }