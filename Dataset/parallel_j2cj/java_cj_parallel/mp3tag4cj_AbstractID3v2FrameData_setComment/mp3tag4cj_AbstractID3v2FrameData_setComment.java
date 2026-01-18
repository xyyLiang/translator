 @Override
 public void setComment(String comment) {
  if (comment != null && comment.length() > 0) {
   invalidateDataLength();
   ID3v2CommentFrameData frameData = new ID3v2CommentFrameData(useFrameUnsynchronisation(), "eng", null, new EncodedText(comment));
   addFrame(createFrame(ID_COMMENT, frameData.toBytes()), true);
  }
 }