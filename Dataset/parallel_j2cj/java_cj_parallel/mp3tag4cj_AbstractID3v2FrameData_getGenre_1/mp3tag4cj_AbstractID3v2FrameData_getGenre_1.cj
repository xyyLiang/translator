    public func getGenre(): Option<Int64> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_GENRE_OBSELETE
            } else {
                ID_GENRE
            }
        )
        if (frameData == Option<ID3v2TextFrameData>.None || frameData.getOrThrow().getText() == Option<EncodedText>.None) {
            return Option<Int64>.Some(-1)
        }
        return getGenre(frameData.getOrThrow().getText().getOrThrow().toString())
    }