 @Override
 public void setAlbumArtist(String albumArtist) {
  if (albumArtist != null && albumArtist.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(albumArtist));
   addFrame(createFrame(ID_ALBUM_ARTIST, frameData.toBytes()), true);
  }
 }