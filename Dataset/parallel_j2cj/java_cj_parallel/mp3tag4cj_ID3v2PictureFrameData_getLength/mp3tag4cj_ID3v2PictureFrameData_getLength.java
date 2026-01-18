 @Override
 protected int getLength() {
  int length = 3;
  if (mimeType != null) length += mimeType.length();
  if (description != null) length += description.toBytes(true, true).length;
  else length++;
  if (imageData != null) length += imageData.length;
  return length;
 }