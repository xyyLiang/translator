 @Override
 public void setLyrics(String lyrics) {
  if (lyrics != null && lyrics.length() > 0) {
   invalidateDataLength();
   ID3v2CommentFrameData frameData = new ID3v2CommentFrameData(useFrameUnsynchronisation(), "eng", null, new EncodedText(lyrics));
   addFrame(createFrame(ID_TEXT_LYRICS, frameData.toBytes()), true);
  }
 }