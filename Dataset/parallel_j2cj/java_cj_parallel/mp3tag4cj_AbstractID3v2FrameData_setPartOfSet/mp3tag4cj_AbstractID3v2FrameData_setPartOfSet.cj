    public open func setPartOfSet(partOfSet: Option<String>): Unit {
        if (partOfSet != Option<String>.None && partOfSet.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(partOfSet.getOrThrow())
            )
            addFrame(createFrame(ID_PART_OF_SET, frameData.toBytes()), true)
        }
    }