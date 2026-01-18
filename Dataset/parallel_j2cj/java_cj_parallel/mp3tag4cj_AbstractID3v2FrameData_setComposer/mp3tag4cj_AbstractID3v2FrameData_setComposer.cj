    public open func setComposer(composer: Option<String>): Unit {
        if (composer != Option<String>.None && composer.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(composer.getOrThrow())
            )
            addFrame(createFrame(ID_COMPOSER, frameData.toBytes()), true)
        }
    }