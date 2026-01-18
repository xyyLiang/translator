 @Override
 protected int getLength() {
  int length = 1;
  length += 16;
  if (id != null)
   length += id.length();
  if (subframes != null) {
   for (ID3v2Frame frame : subframes) {
    length += frame.getLength();
   }
  }
  return length;
 }