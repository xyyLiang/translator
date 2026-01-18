 @Override
 public void setComposer(String composer) {
  if (composer != null && composer.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(composer));
   addFrame(createFrame(ID_COMPOSER, frameData.toBytes()), true);
  }
 }