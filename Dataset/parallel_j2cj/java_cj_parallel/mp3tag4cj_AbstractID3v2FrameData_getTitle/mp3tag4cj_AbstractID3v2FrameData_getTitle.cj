    public open func getTitle(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_TITLE_OBSELETE
            } else {
                ID_TITLE
            }
        )
        return getID3v2TextFrameDataValue(frameData)
    }