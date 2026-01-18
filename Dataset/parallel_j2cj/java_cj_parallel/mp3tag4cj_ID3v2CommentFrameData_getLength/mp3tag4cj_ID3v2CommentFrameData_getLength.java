 @Override
 protected int getLength() {
  int length = 4;
  if (description != null) length += description.toBytes(true, true).length;
  else length += comment != null ? comment.getTerminator().length : 1;
  if (comment != null) length += comment.toBytes(true, false).length;
  return length;
 }
