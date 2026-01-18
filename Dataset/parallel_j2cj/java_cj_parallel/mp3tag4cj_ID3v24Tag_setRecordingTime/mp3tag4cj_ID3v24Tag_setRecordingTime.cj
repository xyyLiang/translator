    public func setRecordingTime(recTime: Option<String>): Unit {
        match (recTime) {
            case Some(x) =>
                if (x.size > 0) {
                    invalidateDataLength()
                    var frameData: ID3v2TextFrameData = ID3v2TextFrameData(useFrameUnsynchronisation(), EncodedText(x))
                    addFrame(createFrame(ID_RECTIME, frameData.toBytes()), true)
                }
            case None => ()
        }
    }