 protected static CharBuffer bytesToCharBuffer(byte[] bytes, String characterSet) throws CharacterCodingException {
  Charset charset = Charset.forName(characterSet);
  CharsetDecoder decoder = charset.newDecoder();
  return decoder.decode(ByteBuffer.wrap(bytes));
 }