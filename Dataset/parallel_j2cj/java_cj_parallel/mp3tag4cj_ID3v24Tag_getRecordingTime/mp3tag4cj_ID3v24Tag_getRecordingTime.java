 public String getRecordingTime() {
  ID3v2TextFrameData frameData = extractTextFrameData(ID_RECTIME);
  if (frameData != null && frameData.getText() != null)
   return frameData.getText().toString();
  return null;
 }