    public open func getAlbum(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_ALBUM_OBSELETE
            } else {
                ID_ALBUM
            }
        )
        return getID3v2TextFrameDataValue(frameData)
    }