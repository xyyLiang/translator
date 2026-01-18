 public void setTextEncoding(byte textEncoding, boolean transcode) throws CharacterCodingException {
  if (this.textEncoding != textEncoding) {
   CharBuffer charBuffer = bytesToCharBuffer(this.value, characterSetForTextEncoding(this.textEncoding));
   byte[] transcodedBytes = charBufferToBytes(charBuffer, characterSetForTextEncoding(textEncoding));
   this.textEncoding = textEncoding;
   this.value = transcodedBytes;
  }
 }