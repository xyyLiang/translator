 @Override
 public void setAlbum(String album) {
  if (album != null && album.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(album));
   addFrame(createFrame(ID_ALBUM, frameData.toBytes()), true);
  }
 }