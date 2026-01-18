 private int maxEndOffset() {
  int maxEndOffset = (int) getLength();
  if (hasId3v1Tag()) maxEndOffset -= ID3v1Tag.TAG_LENGTH;
  return maxEndOffset;
 }
