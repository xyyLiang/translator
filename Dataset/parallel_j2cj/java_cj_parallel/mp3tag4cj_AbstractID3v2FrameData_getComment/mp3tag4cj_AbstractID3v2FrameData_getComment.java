 @Override
 public String getComment() {
  ID3v2CommentFrameData frameData = extractCommentFrameData(obseleteFormat ? ID_COMMENT_OBSELETE : ID_COMMENT, false);
  if (frameData != null && frameData.getComment() != null) return frameData.getComment().toString();
  return null;
 }