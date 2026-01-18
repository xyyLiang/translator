    public open func setTitle(title: Option<String>): Unit {
        if (title != Option<String>.None && title.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(title.getOrThrow())
            )
            addFrame(createFrame(ID_TITLE, frameData.toBytes()), true)
        }
    }