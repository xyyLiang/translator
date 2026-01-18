 @Override
 public void setArtist(String artist) {
  if (artist != null && artist.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(artist));
   addFrame(createFrame(ID_ARTIST, frameData.toBytes()), true);
  }
 }