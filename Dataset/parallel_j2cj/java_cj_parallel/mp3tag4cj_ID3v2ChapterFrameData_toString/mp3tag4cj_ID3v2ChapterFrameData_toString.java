 @Override
 public String toString() {
  StringBuilder builder = new StringBuilder();
  builder.append("ID3v2ChapterFrameData [id=");
  builder.append(id);
  builder.append(", startTime=");
  builder.append(startTime);
  builder.append(", endTime=");
  builder.append(endTime);
  builder.append(", startOffset=");
  builder.append(startOffset);
  builder.append(", endOffset=");
  builder.append(endOffset);
  builder.append(", subframes=");
  builder.append(subframes);
  builder.append("]");
  return builder.toString();
 }