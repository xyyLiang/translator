    private func extractCommentFrameData(id: String, itunes: Bool): Option<ID3v2CommentFrameData> {
        var frameSet: Option<ID3v2FrameSet> = frameSets.get(id)
        match (frameSet) {
            case Some(x) =>
                for (frame in x.getFrames()) {
                    var frameData: ID3v2CommentFrameData
                    try {
                        frameData = ID3v2CommentFrameData(useFrameUnsynchronisation(), frame.getData())
                        if (itunes) {
                            if (ITUNES_COMMENT_DESCRIPTION ==
                                frameData.getDescription().getOrThrow().toString().getOrThrow()) {
                                return frameData
                            }
                        } else if (!itunes) {
                            return frameData
                        }
                    } catch (e: InvalidDataException) {}
                }
            case None => return Option<ID3v2CommentFrameData>.None
        }
        return Option<ID3v2CommentFrameData>.None
    }