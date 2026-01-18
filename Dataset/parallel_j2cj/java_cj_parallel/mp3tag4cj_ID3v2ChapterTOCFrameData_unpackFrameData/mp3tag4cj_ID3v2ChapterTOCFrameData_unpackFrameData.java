 @Override
 protected void unpackFrameData(byte[] bytes) throws InvalidDataException {
  ByteBuffer bb = ByteBuffer.wrap(bytes);

  id = ByteBufferUtils.extractNullTerminatedString(bb);

  byte flags = bb.get();
  if ((flags & 0x01) == 0x01) {
   isRoot = true;
  }
  if ((flags & 0x02) == 0x02) {
   isOrdered = true;
  }

  int childCount = bb.get(); // TODO: 0xFF -> int = 255; byte = -128;

  children = new String[childCount];

  for (int i = 0; i < childCount; i++) {
   children[i] = ByteBufferUtils.extractNullTerminatedString(bb);
  }

  for (int offset = bb.position(); offset < bytes.length; ) {
   ID3v2Frame frame = new ID3v2Frame(bytes, offset);
   offset += frame.getLength();
   subframes.add(frame);
  }

 }