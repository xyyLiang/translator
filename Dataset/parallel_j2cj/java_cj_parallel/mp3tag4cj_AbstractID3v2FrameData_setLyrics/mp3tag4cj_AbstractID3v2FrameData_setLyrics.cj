    public open func setLyrics (lyrics: Option<String>): Unit {
        if (lyrics != Option<String>.None && lyrics.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2CommentFrameData = ID3v2CommentFrameData(useFrameUnsynchronisation(), "eng",
                Option<EncodedText>.None, EncodedText(lyrics.getOrThrow()))
            addFrame(createFrame(ID_TEXT_LYRICS, frameData.toBytes()), true)
        }
    }