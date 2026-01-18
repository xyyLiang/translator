    public open func setComment (comment: Option<String>): Unit {
        if (comment != Option<String>.None && comment.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2CommentFrameData = ID3v2CommentFrameData(useFrameUnsynchronisation(), "eng",
                Option<EncodedText>.None, EncodedText(comment.getOrThrow()))
            addFrame(createFrame(ID_COMMENT, frameData.toBytes()), true)
        }
    }