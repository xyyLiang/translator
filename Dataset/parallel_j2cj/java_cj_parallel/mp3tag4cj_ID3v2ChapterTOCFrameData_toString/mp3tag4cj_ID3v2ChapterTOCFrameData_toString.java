 @Override
 public String toString() {
  StringBuilder builder = new StringBuilder();
  builder.append("ID3v2ChapterTOCFrameData [isRoot=");
  builder.append(isRoot);
  builder.append(", isOrdered=");
  builder.append(isOrdered);
  builder.append(", id=");
  builder.append(id);
  builder.append(", children=");
  builder.append(Arrays.toString(children));
  builder.append(", subframes=");
  builder.append(subframes);
  builder.append("]");
  return builder.toString();
 }