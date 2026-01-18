    public open func setAlbum(album: Option<String>): Unit {
        if (album != Option<String>.None && album.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(album.getOrThrow())
            )
            addFrame(createFrame(ID_ALBUM, frameData.toBytes()), true)
        }
    }