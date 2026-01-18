    protected open func extractLyricsFrameData(id: String): Option<ID3v2CommentFrameData> {
        var frameSet: Option<ID3v2FrameSet> = frameSets.get(id)
        match (frameSet) {
            case Some(x) =>
                for (frame in x.getFrames()) {
                    var frameData: ID3v2CommentFrameData
                    try {
                        frameData = ID3v2CommentFrameData(useFrameUnsynchronisation(), frame.getData())
                        return frameData
                    } catch (e: InvalidDataException) {}
                }
            case None => ()
        }
        return Option<ID3v2CommentFrameData>.None
    }