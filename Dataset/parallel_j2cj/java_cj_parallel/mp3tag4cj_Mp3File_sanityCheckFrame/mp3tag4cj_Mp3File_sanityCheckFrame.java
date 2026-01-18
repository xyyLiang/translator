 private void sanityCheckFrame(MpegFrame frame, int offset) throws InvalidDataException {
  if (sampleRate != frame.getSampleRate()) throw new InvalidDataException("Inconsistent frame header");
  if (!layer.equals(frame.getLayer())) throw new InvalidDataException("Inconsistent frame header");
  if (!version.equals(frame.getVersion())) throw new InvalidDataException("Inconsistent frame header");
  if (offset + frame.getLengthInBytes() > getLength())
   throw new InvalidDataException("Frame would extend beyond end of file");
 }