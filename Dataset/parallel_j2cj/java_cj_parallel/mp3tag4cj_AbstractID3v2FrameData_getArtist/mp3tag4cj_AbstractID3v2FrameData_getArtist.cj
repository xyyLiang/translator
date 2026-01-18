    public open func getArtist(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_ARTIST_OBSELETE
            } else {
                ID_ARTIST
            }
        )
        return getID3v2TextFrameDataValue(frameData)
    }