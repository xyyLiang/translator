    public open func getYear(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_YEAR_OBSELETE
            } else {
                ID_YEAR
            }
        )
        return getID3v2TextFrameDataValue(frameData)
    }
