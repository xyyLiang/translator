    public open func setGenre(genre: Option<Int64>): Unit {
        if (genre != Option<Int64>.None && genre.getOrThrow() >= 0) {
            invalidateDataLength()
            var genreDescription: String = ""
            if (genre.getOrThrow() < ID3v1Genres.GENRES.size) {
                genreDescription = ID3v1Genres.GENRES[genre.getOrThrow()]
            }
            var combinedGenre: String = "(${genre.getOrThrow()})${genreDescription}"
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(combinedGenre)
            )
            addFrame(createFrame(ID_GENRE, frameData.toBytes()), true)
        }
    }