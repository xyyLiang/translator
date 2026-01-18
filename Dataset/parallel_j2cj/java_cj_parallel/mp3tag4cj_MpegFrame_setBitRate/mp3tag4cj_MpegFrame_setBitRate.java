 private void setBitRate(int bitrate) throws InvalidDataException {
  if (MPEG_VERSION_1_0.equals(version)) {
   if (layer == 1) {
    switch (bitrate) {
     case 1:
      this.bitrate = 32;
      return;
     case 2:
      this.bitrate = 64;
      return;
     case 3:
      this.bitrate = 96;
      return;
     case 4:
      this.bitrate = 128;
      return;
     case 5:
      this.bitrate = 160;
      return;
     case 6:
      this.bitrate = 192;
      return;
     case 7:
      this.bitrate = 224;
      return;
     case 8:
      this.bitrate = 256;
      return;
     case 9:
      this.bitrate = 288;
      return;
     case 10:
      this.bitrate = 320;
      return;
     case 11:
      this.bitrate = 352;
      return;
     case 12:
      this.bitrate = 384;
      return;
     case 13:
      this.bitrate = 416;
      return;
     case 14:
      this.bitrate = 448;
      return;
    }
   } else if (layer == 2) {
    switch (bitrate) {
     case 1:
      this.bitrate = 32;
      return;
     case 2:
      this.bitrate = 48;
      return;
     case 3:
      this.bitrate = 56;
      return;
     case 4:
      this.bitrate = 64;
      return;
     case 5:
      this.bitrate = 80;
      return;
     case 6:
      this.bitrate = 96;
      return;
     case 7:
      this.bitrate = 112;
      return;
     case 8:
      this.bitrate = 128;
      return;
     case 9:
      this.bitrate = 160;
      return;
     case 10:
      this.bitrate = 192;
      return;
     case 11:
      this.bitrate = 224;
      return;
     case 12:
      this.bitrate = 256;
      return;
     case 13:
      this.bitrate = 320;
      return;
     case 14:
      this.bitrate = 384;
      return;
    }
   } else if (layer == 3) {
    switch (bitrate) {
     case 1:
      this.bitrate = 32;
      return;
     case 2:
      this.bitrate = 40;
      return;
     case 3:
      this.bitrate = 48;
      return;
     case 4:
      this.bitrate = 56;
      return;
     case 5:
      this.bitrate = 64;
      return;
     case 6:
      this.bitrate = 80;
      return;
     case 7:
      this.bitrate = 96;
      return;
     case 8:
      this.bitrate = 112;
      return;
     case 9:
      this.bitrate = 128;
      return;
     case 10:
      this.bitrate = 160;
      return;
     case 11:
      this.bitrate = 192;
      return;
     case 12:
      this.bitrate = 224;
      return;
     case 13:
      this.bitrate = 256;
      return;
     case 14:
      this.bitrate = 320;
      return;
    }
   }
  } else if (MPEG_VERSION_2_0.equals(version) || MPEG_VERSION_2_5.equals(version)) {
   if (layer == 1) {
    switch (bitrate) {
     case 1:
      this.bitrate = 32;
      return;
     case 2:
      this.bitrate = 48;
      return;
     case 3:
      this.bitrate = 56;
      return;
     case 4:
      this.bitrate = 64;
      return;
     case 5:
      this.bitrate = 80;
      return;
     case 6:
      this.bitrate = 96;
      return;
     case 7:
      this.bitrate = 112;
      return;
     case 8:
      this.bitrate = 128;
      return;
     case 9:
      this.bitrate = 144;
      return;
     case 10:
      this.bitrate = 160;
      return;
     case 11:
      this.bitrate = 176;
      return;
     case 12:
      this.bitrate = 192;
      return;
     case 13:
      this.bitrate = 224;
      return;
     case 14:
      this.bitrate = 256;
      return;
    }
   } else if (layer == 2 || layer == 3) {
    switch (bitrate) {
     case 1:
      this.bitrate = 8;
      return;
     case 2:
      this.bitrate = 16;
      return;
     case 3:
      this.bitrate = 24;
      return;
     case 4:
      this.bitrate = 32;
      return;
     case 5:
      this.bitrate = 40;
      return;
     case 6:
      this.bitrate = 48;
      return;
     case 7:
      this.bitrate = 56;
      return;
     case 8:
      this.bitrate = 64;
      return;
     case 9:
      this.bitrate = 80;
      return;
     case 10:
      this.bitrate = 96;
      return;
     case 11:
      this.bitrate = 112;
      return;
     case 12:
      this.bitrate = 128;
      return;
     case 13:
      this.bitrate = 144;
      return;
     case 14:
      this.bitrate = 160;
      return;
    }
   }
  }
  throw new InvalidDataException("Invalid bitrate in frame header");
 }
