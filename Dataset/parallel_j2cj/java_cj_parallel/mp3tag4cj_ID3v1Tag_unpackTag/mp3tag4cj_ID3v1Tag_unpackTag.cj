    private func unpackTag(bytes: Array<Byte>): Unit {
        sanityCheckTag(bytes)
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, TITLE_OFFSET, TITLE_LENGTH)) {
            case Some(x) => title = BufferTools.trimStringRight(x)
            case None => throw BaseException("title None Exception")
        }
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, ARTIST_OFFSET, ARTIST_LENGTH)) {
            case Some(x) => artist = BufferTools.trimStringRight(x)
            case None => throw BaseException("artist None Exception")
        }
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, ALBUM_OFFSET, ALBUM_LENGTH)) {
            case Some(x) => album = BufferTools.trimStringRight(x)
            case None => throw BaseException("album None Exception")
        }
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, YEAR_OFFSET, YEAR_LENGTH)) {
            case Some(x) => year = BufferTools.trimStringRight(x)
            case None => throw BaseException("year None Exception")
        }
        genre = Int64(bytes[Int64(GENRE_OFFSET)]) & 255
        if (genre == 255) {
            genre = -1
        }

        if (bytes[Int64(TRACK_MARKER_OFFSET)] != 0) {
            match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, COMMENT_OFFSET, COMMENT_LENGTH_V1_0)) {
                case Some(x) => comment = BufferTools.trimStringRight(x)
                case None => throw BaseException("comment None Exception")
            }
            track = ""
        } else {
            match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, COMMENT_OFFSET, COMMENT_LENGTH_V1_1)) {
                case Some(x) =>
                    comment = BufferTools.trimStringRight(x)
                    var trackInt: UInt8 = bytes[Int64(TRACK_OFFSET)]
                    if (trackInt == 0) {
                        track = ""
                    } else {
                        track = trackInt.toString()
                    }
                case None => throw BaseException("comment None Exception")
            }
        }
    }