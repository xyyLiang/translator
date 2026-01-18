    public open func setAlbumArtist(albumArtist: Option<String>): Unit {
        if (albumArtist != Option<String>.None && albumArtist.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(albumArtist.getOrThrow())
            )
            addFrame(createFrame(ID_ALBUM_ARTIST, frameData.toBytes()), true)
        }
    }