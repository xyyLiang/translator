    private func getGenre(text: Option<String>): Option<Int64> {
        if (text != Option<String>.None && text.getOrThrow().size > 0) {
            try {
                return extractGenreNumber(text.getOrThrow())
            } catch (e: Exception) {
                var description: Option<String> = extractGenreDescription(text.getOrThrow())
                return Option<Int64>.Some(Int64(ID3v1Genres.matchGenreDescription(description)))
            }
        }
        return -1
    }