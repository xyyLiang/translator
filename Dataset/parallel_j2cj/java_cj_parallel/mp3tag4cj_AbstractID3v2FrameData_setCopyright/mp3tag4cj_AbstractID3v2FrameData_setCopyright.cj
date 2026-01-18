    public open func setCopyright(copyright: Option<String>): Unit {
        if (copyright != Option<String>.None && copyright.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(copyright.getOrThrow())
            )
            addFrame(createFrame(ID_COPYRIGHT, frameData.toBytes()), true)
        }
    }