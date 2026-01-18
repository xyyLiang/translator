    public func setGenreDescription(text: String): Unit {
        var frameData: ID3v2TextFrameData = ID3v2TextFrameData(useFrameUnsynchronisation(), EncodedText(text))
        var frameSet: ID3v2FrameSet = ID3v2FrameSet("")
        var isNone: Bool = false
        match (getFrameSets().get(ID_GENRE)) {
            case Some(x) => frameSet = x
            case None => isNone = true
        }
        if (isNone) {
            frameSet = ID3v2FrameSet(ID_GENRE)
            getFrameSets().put(ID_GENRE, frameSet)
        }
        frameSet.clear()
        frameSet.addFrame(createFrame(ID_GENRE, frameData.toBytes()))
    }