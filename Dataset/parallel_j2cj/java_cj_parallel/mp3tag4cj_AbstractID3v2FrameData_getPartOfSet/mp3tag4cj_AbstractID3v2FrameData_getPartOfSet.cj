    public open func getPartOfSet(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_PART_OF_SET_OBSELETE
            } else {
                ID_PART_OF_SET
            }
        )
        return getID3v2TextFrameDataValue(frameData)
    }