    public open func setKey(key: Option<String>): Unit {
        if (key != Option<String>.None && key.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(key.getOrThrow())
            )
            addFrame(createFrame(ID_KEY, frameData.toBytes()), true)
        }
    }