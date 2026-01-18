    public open func setArtist(artist: Option<String>): Unit {
        if (artist != Option<String>.None && artist.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(artist.getOrThrow())
            )
            addFrame(createFrame(ID_ARTIST, frameData.toBytes()), true)
        }
    }