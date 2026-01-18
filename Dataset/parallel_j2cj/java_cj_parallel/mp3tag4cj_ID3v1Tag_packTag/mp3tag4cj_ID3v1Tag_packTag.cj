    @OverflowWrapping
    public func packTag(bytes: Array<Int8>): Unit {
        try {
            BufferTools.stringIntoByteBuffer(TAG, 0, 3, bytes, 0)
        } catch (e: Exception) {
            throw NoSuchTagException("TAG pack fail")
        }
        packField(bytes, title, TITLE_LENGTH, TITLE_OFFSET);
        packField(bytes, artist, ARTIST_LENGTH, ARTIST_OFFSET);
        packField(bytes, album, ALBUM_LENGTH, ALBUM_OFFSET);
        packField(bytes, year, YEAR_LENGTH, YEAR_OFFSET);
        match (genre) {
            case Some(x) =>
                if (x < 128) {
                    bytes[Int64(GENRE_OFFSET)] = Int8(x)
                } else {
                    bytes[Int64(GENRE_OFFSET)] = Int8(x - 256)
                }
            case None => ()
        }
        match (track) {
            case Some(x) =>
                packField(bytes, comment, COMMENT_LENGTH_V1_1, COMMENT_OFFSET)
                var trackTemp: String = numericsOnly(x)
                if (trackTemp.size > 0) {
                    var trackInt: Int64 = Int64.parse(trackTemp)
                    if (trackInt < 128) {
                        bytes[Int64(TRACK_OFFSET)] = Int8(trackInt)
                    } else {
                        bytes[Int64(TRACK_OFFSET)] = Int8(trackInt - 256)
                    }
                }
            case None =>
                packField(bytes, comment, COMMENT_LENGTH_V1_0, COMMENT_OFFSET)
        }
    }