    public open func getGrouping(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_GROUPING_OBSELETE
            } else {
                ID_GROUPING
            }
        )
        return getID3v2TextFrameDataValue(frameData)
    }