 @Override
 public void setOriginalArtist(String originalArtist) {
  if (originalArtist != null && originalArtist.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(originalArtist));
   addFrame(createFrame(ID_ORIGINAL_ARTIST, frameData.toBytes()), true);
  }
 }