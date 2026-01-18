 @Override
 public String getItunesComment() {
  ID3v2CommentFrameData frameData = extractCommentFrameData(obseleteFormat ? ID_COMMENT_OBSELETE : ID_COMMENT, true);
  if (frameData != null && frameData.getComment() != null) return frameData.getComment().toString();
  return null;
 }