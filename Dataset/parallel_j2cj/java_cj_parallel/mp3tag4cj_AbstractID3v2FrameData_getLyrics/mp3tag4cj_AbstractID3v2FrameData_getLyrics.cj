    public open func getLyrics(): Option<String> {
        var frameData: Option<ID3v2CommentFrameData>
        if (obseleteFormat) {
            return Option<String>.None
        } else {
            frameData = extractLyricsFrameData(ID_TEXT_LYRICS)
        }
        if (frameData != Option<ID3v2CommentFrameData>.None) {
            if (frameData.getOrThrow().getComment() != Option<EncodedText>.None) {
                return frameData.getOrThrow().getComment().getOrThrow().toString()
            }
        }
        return Option<String>.None
    }