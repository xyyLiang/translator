    public open func setEncoder(encoder: Option<String>): Unit {
        if (encoder != Option<String>.None && encoder.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(encoder.getOrThrow())
            )
            addFrame(createFrame(ID_ENCODER, frameData.toBytes()), true)
        }
    }