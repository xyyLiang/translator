    protected open func addFrame(frame: ID3v2Frame, replace: Bool): Unit {
        var frameSetVar: ID3v2FrameSet = ID3v2FrameSet("")
        var isNone: Bool = false
        match (frameSets.get(frame.getId())) {
            case Some(x) => frameSetVar = x
            case None => isNone = true
        }
        if (isNone) {
            frameSetVar = ID3v2FrameSet(frame.getId())
            frameSetVar.addFrame(frame)
            frameSets.put(frame.getId(), frameSetVar)
            ()
        } else if (replace) {
            frameSetVar.clear()
            frameSetVar.addFrame(frame)
        } else {
            frameSetVar.addFrame(frame)
        }
    }