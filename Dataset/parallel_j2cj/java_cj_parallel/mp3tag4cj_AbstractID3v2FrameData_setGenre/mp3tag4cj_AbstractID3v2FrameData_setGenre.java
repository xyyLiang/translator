 @Override
 public void setGenre(int genre) {
  if (genre >= 0) {
   invalidateDataLength();
   String genreDescription = genre < ID3v1Genres.GENRES.length ? ID3v1Genres.GENRES[genre] : "";
   String combinedGenre = "(" + (genre) + ")" + genreDescription;
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(combinedGenre));
   addFrame(createFrame(ID_GENRE, frameData.toBytes()), true);
  } else {
   // TODO remove frame?
  }
 }