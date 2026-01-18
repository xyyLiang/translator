    public open func setTrack(track: Option<String>): Unit {
        if (track != Option<String>.None && track.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(track.getOrThrow())
            )
            addFrame(createFrame(ID_TRACK, frameData.toBytes()), true)
        }
    }