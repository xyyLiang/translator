 @Override
 protected byte[] packFrameData() {
  byte[] bytes = new byte[getLength()];
  if (comment != null) bytes[0] = comment.getTextEncoding();
  else bytes[0] = 0;
  String langPadded;
  if (language == null) {
   langPadded = DEFAULT_LANGUAGE;
  } else if (language.length() > 3) {
   langPadded = language.substring(0, 3);
  } else {
   langPadded = BufferTools.padStringRight(language, 3, '\00');
  }
  try {
   BufferTools.stringIntoByteBuffer(langPadded, 0, 3, bytes, 1);
  } catch (UnsupportedEncodingException e) {
  }
  int marker = 4;
  if (description != null) {
   byte[] descriptionBytes = description.toBytes(true, true);
   BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.length, bytes, marker);
   marker += descriptionBytes.length;
  } else {
   byte[] terminatorBytes = comment != null ? comment.getTerminator() : new byte[]{0};
   BufferTools.copyIntoByteBuffer(terminatorBytes, 0, terminatorBytes.length, bytes, marker);
   marker += terminatorBytes.length;
  }
  if (comment != null) {
   byte[] commentBytes = comment.toBytes(true, false);
   BufferTools.copyIntoByteBuffer(commentBytes, 0, commentBytes.length, bytes, marker);
  }
  return bytes;
 }
