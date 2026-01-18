 @Override
 public int getDataLength() {
  if (dataLength == 0) {
   dataLength = calculateDataLength();
  }
  return dataLength;
 }