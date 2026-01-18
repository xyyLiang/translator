 @Override
 protected void unpackFrameData(byte[] bytes) {
  try {
   address = BufferTools.byteBufferToString(bytes, 0, bytes.length - 2);
  } catch (UnsupportedEncodingException e) {
   address = "";
  }
  final byte ratingByte = bytes[bytes.length - 1];
  rating = byteToRating.getOrDefault(ratingByte, -1);

 }