    public open func getTrack(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_TRACK_OBSELETE
            } else {
                ID_TRACK
            }
        )
        return getID3v2TextFrameDataValue(frameData)
    }