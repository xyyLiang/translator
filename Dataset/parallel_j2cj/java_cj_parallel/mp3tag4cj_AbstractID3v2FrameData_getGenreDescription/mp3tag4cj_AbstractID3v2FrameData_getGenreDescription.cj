    public open func getGenreDescription(): String {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_GENRE_OBSELETE
            } else {
                ID_GENRE
            }
        )
        if (frameData == Option<ID3v2TextFrameData>.None || frameData.getOrThrow().getText() == Option<EncodedText>.None) {
            return ""
        }
        var text: Option<String> = frameData.getOrThrow().getText().getOrThrow().toString();
        if (text != Option<String>.None) {
            var genreNumOp: Option<Int64> = getGenre(text)
            var genreNum: Int64
            match (genreNumOp) {
                case Some(x) => genreNum = x
                case None => genreNum = -1
            }
            if (genreNum >= 0 && genreNum < ID3v1Genres.GENRES.size) {
                return ID3v1Genres.GENRES[genreNum]
            } else {
                var description: Option<String> = extractGenreDescription(text.getOrThrow())
                if (description != Option<String>.None && description.getOrThrow().size > 0) {
                    return description.getOrThrow()
                }
            }
        }
        return ""
    }
