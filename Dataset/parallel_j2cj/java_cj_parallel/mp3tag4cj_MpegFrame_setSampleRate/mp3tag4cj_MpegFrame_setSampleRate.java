 private void setSampleRate(int sampleRate) throws InvalidDataException {
  if (MPEG_VERSION_1_0.equals(version)) {
   switch (sampleRate) {
    case 0:
     this.sampleRate = 44100;
     return;
    case 1:
     this.sampleRate = 48000;
     return;
    case 2:
     this.sampleRate = 32000;
     return;
   }
  } else if (MPEG_VERSION_2_0.equals(version)) {
   switch (sampleRate) {
    case 0:
     this.sampleRate = 22050;
     return;
    case 1:
     this.sampleRate = 24000;
     return;
    case 2:
     this.sampleRate = 16000;
     return;
   }
  } else if (MPEG_VERSION_2_5.equals(version)) {
   switch (sampleRate) {
    case 0:
     this.sampleRate = 11025;
     return;
    case 1:
     this.sampleRate = 12000;
     return;
    case 2:
     this.sampleRate = 8000;
     return;
   }
  }
  throw new InvalidDataException("Invalid sample rate in frame header");
 }
