 @Override
 protected int getLength() {
  int length = 1;
  if (text != null) length += text.toBytes(true, false).length;
  return length;
 }