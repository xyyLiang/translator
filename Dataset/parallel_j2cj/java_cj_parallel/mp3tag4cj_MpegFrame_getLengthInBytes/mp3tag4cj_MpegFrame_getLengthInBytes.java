 public int getLengthInBytes() {
  long length;
  int pad;
  if (padding) pad = 1;
  else pad = 0;
  if (layer == 1) {
   length = ((48000 * bitrate) / sampleRate) + (pad * 4);
  } else {
   length = ((144000 * bitrate) / sampleRate) + pad;
  }
  return (int) length;
 }