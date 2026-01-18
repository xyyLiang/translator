    public open func setPublisher(publisher: Option<String>): Unit {
        if (publisher != Option<String>.None && publisher.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(publisher.getOrThrow())
            )
            addFrame(createFrame(ID_PUBLISHER, frameData.toBytes()), true)
        }
    }
