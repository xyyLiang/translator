    public func encode(context: EncoderContext): Unit {
        let buffer = StringBuilder()
        buffer.append('\u{0}')
        while (context.hasMoreCharacters()) {
            let c = context.getCurrent()
            buffer.append(c)

            context.pos++

            let newMode = HighLevelEncoder.lookAheadTest(context.msg, context.pos, getEncodingMode())
            if (newMode != getEncodingMode()) {
                context.newEncoding = HighLevelEncoder.ASCII_ENCODATION
                break
            }
        }
        let dataCount = buffer.size - 1
        let lengthFieldSize = 1
        let currentSize = context.getCodewordCount() + dataCount + lengthFieldSize
        context.updateSymbolInfo(currentSize)
        let mustPad = (context.symbolInfo.getOrThrow().dataCapacity - currentSize) > 0
        if (context.hasMoreCharacters() || mustPad) {
            if (dataCount <= 249) {
                buffer.removeFirst()
                buffer.insert(0, Char(dataCount))
            } else if (dataCount <= 1555) {
                buffer.removeFirst()
                buffer.insert(0, Char((dataCount / 250) + 249))
                buffer.insert(1, Char(dataCount % 250))
            } else {
                throw IllegalArgumentException("Message length not in valid ranges: ${dataCount}")
            }
        }
        for (i in 0..buffer.size) {
            context.writeCodeword(randomize255State(buffer.get(i).getOrThrow(), context.getCodewordCount() + 1))
        }
    }