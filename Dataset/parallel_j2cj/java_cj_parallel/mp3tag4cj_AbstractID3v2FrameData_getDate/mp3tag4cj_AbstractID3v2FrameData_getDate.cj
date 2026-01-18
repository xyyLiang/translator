    public open func getDate(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_DATE_OBSELETE
            } else {
                ID_DATE
            }
        )
        return getID3v2TextFrameDataValue(frameData)
    }