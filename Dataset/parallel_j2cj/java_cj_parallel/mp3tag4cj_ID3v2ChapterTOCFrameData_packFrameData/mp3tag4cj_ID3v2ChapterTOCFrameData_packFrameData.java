 @Override
 protected byte[] packFrameData() {
  ByteBuffer bb = ByteBuffer.allocate(getLength());
  bb.put(id.getBytes());
  bb.put((byte) 0);
  bb.put(getFlags());
  bb.put((byte) children.length);

  for (String child : children) {
   bb.put(child.getBytes());
   bb.put((byte) 0);
  }

  for (ID3v2Frame frame : subframes) {
   try {
    bb.put(frame.toBytes());
   } catch (NotSupportedException e) {
    e.printStackTrace();
   }
  }
  return bb.array();
 }