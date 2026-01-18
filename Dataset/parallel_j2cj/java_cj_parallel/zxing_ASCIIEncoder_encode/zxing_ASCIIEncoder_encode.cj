    public func encode(context: EncoderContext): Unit {
        let n = HighLevelEncoder.determineConsecutiveDigitCount(context.msg, context.pos)
        if (n >= 2) {
            context.writeCodeword(
                encodeASCIIDigits(
                    context.msg.charAt(context.pos),
                    context.msg.charAt(context.pos + 1)
                )
            )
            context.pos += 2
        } else {
            let c = context.getCurrent()
            let newMode = HighLevelEncoder.lookAheadTest(context.msg, context.pos, getEncodingMode())
            if (newMode != getEncodingMode()) {
                if (newMode == HighLevelEncoder.BASE256_ENCODATION) {
                    context.writeCodeword(HighLevelEncoder.LATCH_TO_BASE256)
                    context.newEncoding = HighLevelEncoder.BASE256_ENCODATION
                    return
                } else if (newMode == HighLevelEncoder.C40_ENCODATION) {
                    context.writeCodeword(HighLevelEncoder.LATCH_TO_C40)
                    context.newEncoding = HighLevelEncoder.C40_ENCODATION
                    return
                } else if (newMode == HighLevelEncoder.X12_ENCODATION) {
                    context.writeCodeword(HighLevelEncoder.LATCH_TO_ANSIX12)
                    context.newEncoding = HighLevelEncoder.X12_ENCODATION
                } else if (newMode == HighLevelEncoder.TEXT_ENCODATION) {
                    context.writeCodeword(HighLevelEncoder.LATCH_TO_TEXT)
                    context.newEncoding = HighLevelEncoder.TEXT_ENCODATION
                } else if (newMode == HighLevelEncoder.EDIFACT_ENCODATION) {
                    context.writeCodeword(HighLevelEncoder.LATCH_TO_EDIFACT)
                    context.newEncoding = HighLevelEncoder.EDIFACT_ENCODATION
                } else {
                    throw IllegalArgumentException("Illegal mode: ${newMode}")
                }
            } else if (HighLevelEncoder.isExtendedASCII(c)) {
                context.writeCodeword(HighLevelEncoder.UPPER_SHIFT)
                context.writeCodeword(Char(UInt32(c) - 128 + 1))
                context.pos++
            } else {
                context.writeCodeword(Char(UInt32(c) + 1))
                context.pos++
            }
        }
    }