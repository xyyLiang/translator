 public void packTag(byte[] bytes) {
  Arrays.fill(bytes, (byte) 0);
  try {
   BufferTools.stringIntoByteBuffer(TAG, 0, 3, bytes, 0);
  } catch (UnsupportedEncodingException e) {
  }
  packField(bytes, title, TITLE_LENGTH, TITLE_OFFSET);
  packField(bytes, artist, ARTIST_LENGTH, ARTIST_OFFSET);
  packField(bytes, album, ALBUM_LENGTH, ALBUM_OFFSET);
  packField(bytes, year, YEAR_LENGTH, YEAR_OFFSET);
  if (genre < 128) {
   bytes[GENRE_OFFSET] = (byte) genre;
  } else {
   bytes[GENRE_OFFSET] = (byte) (genre - 256);
  }
  if (track == null) {
   packField(bytes, comment, COMMENT_LENGTH_V1_0, COMMENT_OFFSET);
  } else {
   packField(bytes, comment, COMMENT_LENGTH_V1_1, COMMENT_OFFSET);
   String trackTemp = numericsOnly(track);
   if (trackTemp.length() > 0) {
    int trackInt = Integer.parseInt(trackTemp);
    if (trackInt < 128) {
     bytes[TRACK_OFFSET] = (byte) trackInt;
    } else {
     bytes[TRACK_OFFSET] = (byte) (trackInt - 256);
    }
   }
  }
 }
