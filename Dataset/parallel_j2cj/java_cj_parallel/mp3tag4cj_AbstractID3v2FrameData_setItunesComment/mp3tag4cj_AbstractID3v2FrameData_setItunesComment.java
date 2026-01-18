 @Override
 public void setItunesComment(String itunesComment) {
  if (itunesComment != null && itunesComment.length() > 0) {
   invalidateDataLength();
   ID3v2CommentFrameData frameData = new ID3v2CommentFrameData(useFrameUnsynchronisation(), "eng", new EncodedText(ITUNES_COMMENT_DESCRIPTION), new EncodedText(itunesComment));
   addFrame(createFrame(ID_COMMENT, frameData.toBytes()), true);
  }
 }