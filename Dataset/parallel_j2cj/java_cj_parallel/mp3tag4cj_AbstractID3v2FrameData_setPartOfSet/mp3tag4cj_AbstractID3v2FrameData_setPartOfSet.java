 @Override
 public void setPartOfSet(String partOfSet) {
  if (partOfSet != null && partOfSet.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(partOfSet));
   addFrame(createFrame(ID_PART_OF_SET, frameData.toBytes()), true);
  }
 }