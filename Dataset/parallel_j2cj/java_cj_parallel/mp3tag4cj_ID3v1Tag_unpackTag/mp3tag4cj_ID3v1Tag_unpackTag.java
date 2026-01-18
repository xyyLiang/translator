 private void unpackTag(byte[] bytes) throws NoSuchTagException {
  sanityCheckTag(bytes);
  title = BufferTools.trimStringRight(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, TITLE_OFFSET, TITLE_LENGTH));
  artist = BufferTools.trimStringRight(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, ARTIST_OFFSET, ARTIST_LENGTH));
  album = BufferTools.trimStringRight(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, ALBUM_OFFSET, ALBUM_LENGTH));
  year = BufferTools.trimStringRight(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, YEAR_OFFSET, YEAR_LENGTH));
  genre = bytes[GENRE_OFFSET] & 0xFF;
  if (genre == 0xFF) {
   genre = -1;
  }
  if (bytes[TRACK_MARKER_OFFSET] != 0) {
   comment = BufferTools.trimStringRight(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, COMMENT_OFFSET, COMMENT_LENGTH_V1_0));
   track = null;
  } else {
   comment = BufferTools.trimStringRight(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, COMMENT_OFFSET, COMMENT_LENGTH_V1_1));
   int trackInt = bytes[TRACK_OFFSET];
   if (trackInt == 0) {
    track = "";
   } else {
    track = Integer.toString(trackInt);
   }
  }
 }