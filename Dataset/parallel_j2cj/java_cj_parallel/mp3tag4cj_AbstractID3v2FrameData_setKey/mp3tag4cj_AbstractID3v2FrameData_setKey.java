    /**
     * The Function is setKey
     *  @Override
 public void setKey(String key) {
  if (key != null && key.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(key));
   addFrame(createFrame(ID_KEY, frameData.toBytes()), true);
  }
 }
     * @param key of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */