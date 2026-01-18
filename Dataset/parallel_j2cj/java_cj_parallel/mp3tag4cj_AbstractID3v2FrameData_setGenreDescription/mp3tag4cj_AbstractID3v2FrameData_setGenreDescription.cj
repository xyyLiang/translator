    public open func setGenreDescription(text: Option<String>): Unit {
        var genreNum: Int32 = ID3v1Genres.matchGenreDescription(text)
        if (genreNum < 0) {
            throw IllegalArgumentException("Unknown genre: ${text.getOrDefault({=>""})}")
        }
        setGenre(Option<Int64>.Some(Int64(genreNum)))
    }