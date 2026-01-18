    public override func encode(context: EncoderContext) {
        let buffer = StringBuilder()
        while (context.hasMoreCharacters()) {
            let c = context.getCurrent()
            context.pos++

            encodeChar(c, buffer)

            let count = buffer.size
            if ((count % 3) == 0) {
                writeNextTriplet(context, buffer)

                let newMode = HighLevelEncoder.lookAheadTest(context.msg, context.pos, getEncodingMode())
                if (newMode != getEncodingMode()) {
                    context.newEncoding = HighLevelEncoder.ASCII_ENCODATION
                    break
                }
            }
        }
        handleEOD(context, buffer)
    }