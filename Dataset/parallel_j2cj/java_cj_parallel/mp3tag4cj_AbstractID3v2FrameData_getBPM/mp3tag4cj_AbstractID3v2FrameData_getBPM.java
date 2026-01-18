 @Override
 public int getBPM() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_BPM_OBSELETE : ID_BPM);
  if (frameData == null || frameData.getText() == null) {
   return -1;
  }
  String bpmStr = frameData.getText().toString();
  try {
   return Integer.parseInt(bpmStr);
  } catch (NumberFormatException e) {
   // try float as some utilities add BPM like 67.8, or 67,8
   return (int) Float.parseFloat(bpmStr.trim().replaceAll(",", "."));
  }
 }