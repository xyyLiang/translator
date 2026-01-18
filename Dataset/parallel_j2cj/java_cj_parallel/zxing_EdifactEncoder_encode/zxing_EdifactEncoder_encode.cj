    public func encode(context: EncoderContext): Unit {
        let buffer = StringBuilder()
        while (context.hasMoreCharacters()) {
            let c = context.getCurrent()
            encodeChar(c, buffer)
            context.pos++

            let count = buffer.size
            if (count >= 4) {
                context.writeCodewords(encodeToCodewords(buffer))
                buffer.remove(0..4)

                let newMode = HighLevelEncoder.lookAheadTest(context.msg, context.pos, getEncodingMode())
                if (newMode != getEncodingMode()) {
                    context.newEncoding = HighLevelEncoder.ASCII_ENCODATION
                    break
                }
            }
        }
        buffer.append(Char(31))
        handleEOD(context, buffer)
    }