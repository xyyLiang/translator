    public open func setOriginalArtist(originalArtist: Option<String>): Unit {
        if (originalArtist != Option<String>.None && originalArtist.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(originalArtist.getOrThrow())
            )
            addFrame(createFrame(ID_ORIGINAL_ARTIST, frameData.toBytes()), true)
        }
    }