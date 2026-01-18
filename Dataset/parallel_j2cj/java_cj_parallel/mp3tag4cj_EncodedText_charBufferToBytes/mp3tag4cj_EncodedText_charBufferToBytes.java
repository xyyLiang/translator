 protected static byte[] charBufferToBytes(CharBuffer charBuffer, String characterSet) throws CharacterCodingException {
  Charset charset = Charset.forName(characterSet);
  CharsetEncoder encoder = charset.newEncoder();
  ByteBuffer byteBuffer = encoder.encode(charBuffer);
  return BufferTools.copyBuffer(byteBuffer.array(), 0, byteBuffer.limit());
 }