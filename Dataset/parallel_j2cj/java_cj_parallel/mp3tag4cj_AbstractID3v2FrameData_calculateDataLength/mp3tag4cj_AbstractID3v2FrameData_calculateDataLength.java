 private int calculateDataLength() {
  int length = 0;
  if (extendedHeader) length += extendedHeaderLength;
  if (footer) length += FOOTER_LENGTH;
  else if (padding) length += PADDING_LENGTH;
  for (ID3v2FrameSet frameSet : frameSets.values()) {
   for (ID3v2Frame frame : frameSet.getFrames()) {
    length += frame.getLength();
   }
  }
  return length;
 }