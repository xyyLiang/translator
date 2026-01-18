 @Override
 protected byte[] packFrameData() {
  ByteBuffer bb = ByteBuffer.allocate(getLength());
  bb.put(id.getBytes());
  bb.put((byte) 0);

  bb.putInt(startTime);
  bb.putInt(endTime);
  bb.putInt(startOffset);
  bb.putInt(endOffset);

  for (ID3v2Frame frame : subframes) {
   try {
    bb.put(frame.toBytes());
   } catch (NotSupportedException e) {
    e.printStackTrace();
   }
  }
  return bb.array();
 }
