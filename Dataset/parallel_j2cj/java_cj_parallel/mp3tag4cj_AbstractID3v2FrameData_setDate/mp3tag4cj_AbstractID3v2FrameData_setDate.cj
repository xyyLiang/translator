    public open func setDate(date: Option<String>): Unit {
        if (date != Option<String>.None && date.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(date.getOrThrow())
            )
            addFrame(createFrame(ID_DATE, frameData.toBytes()), true)
        }
    }