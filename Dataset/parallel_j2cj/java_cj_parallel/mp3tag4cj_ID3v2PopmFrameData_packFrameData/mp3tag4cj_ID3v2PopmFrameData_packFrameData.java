 @Override
 protected byte[] packFrameData() {
  byte[] bytes = address.getBytes();
  bytes = Arrays.copyOf(bytes, address.length() + 2);
  bytes[bytes.length - 2] = 0;
  bytes[bytes.length - 1] = wmp9encodedRatings[rating];
  return bytes;
 }