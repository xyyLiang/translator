    public open func setCompilation(compilation: Bool): Unit {
        invalidateDataLength()
        var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
            useFrameUnsynchronisation(),
            EncodedText(
                if (compilation) {
                    "1"
                } else {
                    "0"
                }
            )
        );
        addFrame(createFrame(ID_COMPILATION, frameData.toBytes()), true)
    }