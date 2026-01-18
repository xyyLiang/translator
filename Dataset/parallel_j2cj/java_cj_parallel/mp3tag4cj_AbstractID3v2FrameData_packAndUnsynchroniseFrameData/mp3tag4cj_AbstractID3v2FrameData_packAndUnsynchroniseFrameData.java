 protected byte[] packAndUnsynchroniseFrameData() {
  byte[] bytes = packFrameData();
  if (unsynchronisation && BufferTools.sizeUnsynchronisationWouldAdd(bytes) > 0) {
   return BufferTools.unsynchroniseBuffer(bytes);
  }
  return bytes;
 }