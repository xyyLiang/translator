    public open func setItunesComment (itunesComment: Option<String>): Unit {
        if (itunesComment != Option<String>.None && itunesComment.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2CommentFrameData = ID3v2CommentFrameData(
                useFrameUnsynchronisation(),
                "eng",
                EncodedText(ITUNES_COMMENT_DESCRIPTION),
                EncodedText(itunesComment.getOrThrow())
            )
            addFrame(createFrame(ID_COMMENT, frameData.toBytes()), true)
        }
    }