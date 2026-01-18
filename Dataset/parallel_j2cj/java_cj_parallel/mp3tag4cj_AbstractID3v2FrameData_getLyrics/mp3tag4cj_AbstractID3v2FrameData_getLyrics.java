 @Override
 public String getLyrics() {
  ID3v2CommentFrameData frameData;
  if (obseleteFormat)
   return null;
  else
   frameData = extractLyricsFrameData(ID_TEXT_LYRICS);

  if (frameData != null)
   return frameData.getComment().toString();

  return null;
 }