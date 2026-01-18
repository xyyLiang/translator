    public open func setYear(year: Option<String>): Unit {
        if (year != Option<String>.None && year.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(year.getOrThrow())
            )
            addFrame(createFrame(ID_YEAR, frameData.toBytes()), true)
        }
    }