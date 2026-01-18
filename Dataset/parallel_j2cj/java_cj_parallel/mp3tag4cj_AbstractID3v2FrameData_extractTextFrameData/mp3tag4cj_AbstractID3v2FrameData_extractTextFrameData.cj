    protected open func extractTextFrameData(id: String): Option<ID3v2TextFrameData> {
        var frameSet: Option<ID3v2FrameSet> = frameSets.get(id)
        match (frameSet) {
            case Some(x) =>
                var frame: ID3v2Frame = x.getFrames()[0]
                var frameData: ID3v2TextFrameData
                try {
                    frameData = ID3v2TextFrameData(useFrameUnsynchronisation(), frame.getData())
                    return frameData
                } catch (e: InvalidDataException) {}
            case None => ()
        }
        return Option<ID3v2TextFrameData>.None
    }