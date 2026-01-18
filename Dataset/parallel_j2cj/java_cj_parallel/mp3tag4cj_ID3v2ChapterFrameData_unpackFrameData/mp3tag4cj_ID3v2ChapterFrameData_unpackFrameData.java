 @Override
 protected void unpackFrameData(byte[] bytes) throws InvalidDataException {
  ByteBuffer bb = ByteBuffer.wrap(bytes);

  id = ByteBufferUtils.extractNullTerminatedString(bb);

  bb.position(id.length() + 1);
  startTime = bb.getInt();
  endTime = bb.getInt();
  startOffset = bb.getInt();
  endOffset = bb.getInt();

  for (int offset = bb.position(); offset < bytes.length; ) {
   ID3v2Frame frame = new ID3v2Frame(bytes, offset);
   offset += frame.getLength();
   subframes.add(frame);
  }

 }