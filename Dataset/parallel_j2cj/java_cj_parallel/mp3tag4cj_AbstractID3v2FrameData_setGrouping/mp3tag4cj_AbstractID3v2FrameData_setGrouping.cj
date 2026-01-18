    public open func setGrouping(grouping: Option<String>): Unit {
        if (grouping != Option<String>.None && grouping.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(grouping.getOrThrow())
            )
            addFrame(createFrame(ID_GROUPING, frameData.toBytes()), true)
        }
    }
