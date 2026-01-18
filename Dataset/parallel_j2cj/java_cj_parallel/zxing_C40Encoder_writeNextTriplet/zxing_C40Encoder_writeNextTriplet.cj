    func writeNextTriplet(context: EncoderContext, buffer: StringBuilder) {
        context.writeCodewords(encodeToCodewords(buffer))
        buffer.remove(0..3)
    }