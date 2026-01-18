 @Override
 protected int getLength() {
  int length = 1;
  if (description != null) length += description.toBytes(true, true).length;
  else length++;
  if (url != null) length += url.length();
  return length;
 }