 private void setFields(long frameHeader) throws InvalidDataException {
  long frameSync = extractField(frameHeader, BITMASK_FRAME_SYNC);
  if (frameSync != FRAME_SYNC) throw new InvalidDataException("Frame sync missing");
  setVersion(extractField(frameHeader, BITMASK_VERSION));
  setLayer(extractField(frameHeader, BITMASK_LAYER));
  setProtection(extractField(frameHeader, BITMASK_PROTECTION));
  setBitRate(extractField(frameHeader, BITMASK_BITRATE));
  setSampleRate(extractField(frameHeader, BITMASK_SAMPLE_RATE));
  setPadding(extractField(frameHeader, BITMASK_PADDING));
  setPrivate(extractField(frameHeader, BITMASK_PRIVATE));
  setChannelMode(extractField(frameHeader, BITMASK_CHANNEL_MODE));
  setModeExtension(extractField(frameHeader, BITMASK_MODE_EXTENSION));
  setCopyright(extractField(frameHeader, BITMASK_COPYRIGHT));
  setOriginal(extractField(frameHeader, BITMASK_ORIGINAL));
  setEmphasis(extractField(frameHeader, BITMASK_EMPHASIS));
 }