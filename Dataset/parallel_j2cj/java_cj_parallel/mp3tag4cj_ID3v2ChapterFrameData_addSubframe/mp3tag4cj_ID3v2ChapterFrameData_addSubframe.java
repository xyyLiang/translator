 public void addSubframe(String id, AbstractID3v2FrameData frame) {
  subframes.add(new ID3v2Frame(id, frame.toBytes()));
 }