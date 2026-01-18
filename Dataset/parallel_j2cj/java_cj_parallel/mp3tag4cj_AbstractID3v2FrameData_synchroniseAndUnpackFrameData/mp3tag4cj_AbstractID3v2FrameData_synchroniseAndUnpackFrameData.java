 protected final void synchroniseAndUnpackFrameData(byte[] bytes) throws InvalidDataException {
  if (unsynchronisation && BufferTools.sizeSynchronisationWouldSubtract(bytes) > 0) {
   byte[] synchronisedBytes = BufferTools.synchroniseBuffer(bytes);
   unpackFrameData(synchronisedBytes);
  } else {
   unpackFrameData(bytes);
  }
 }