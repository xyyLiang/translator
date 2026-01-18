    public open func getAlbumArtist(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_ALBUM_ARTIST_OBSELETE
            } else {
                ID_ALBUM_ARTIST
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None) {
            if (frameData.getOrThrow().getText() != Option<EncodedText>.None) {
                if (frameData.getOrThrow().getText() != Option<EncodedText>.None) {
                    match (frameData.getOrThrow().getText()) {
                        case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                        case None => ()
                    }
                }
            }
        }
        return Option<String>.None
    }