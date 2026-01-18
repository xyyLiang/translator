    public open func getItunesComment(): Option<String> {
        var frameData: Option<ID3v2CommentFrameData> = extractCommentFrameData(
            if (obseleteFormat) {
                ID_COMMENT_OBSELETE
            } else {
                ID_COMMENT
            },
            true
        )
        if (frameData != Option<ID3v2CommentFrameData>.None) {
            if (frameData.getOrThrow().getComment() != Option<EncodedText>.None) {
                return frameData.getOrThrow().getComment().getOrThrow().toString()
            }
        }
        return Option<String>.None
    }