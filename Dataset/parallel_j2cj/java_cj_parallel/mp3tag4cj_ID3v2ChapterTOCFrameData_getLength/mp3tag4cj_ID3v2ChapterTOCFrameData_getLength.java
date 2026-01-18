 @Override
 protected int getLength() {
  int length = 3;
  if (id != null) length += id.length();
  if (children != null) {
   length += children.length;
   for (String child : children) {
    length += child.length();
   }
  }
  if (subframes != null) {
   for (ID3v2Frame frame : subframes) {
    length += frame.getLength();
   }
  }
  return length;
 }