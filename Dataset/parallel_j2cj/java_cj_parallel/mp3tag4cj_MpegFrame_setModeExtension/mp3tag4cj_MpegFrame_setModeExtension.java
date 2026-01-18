 private void setModeExtension(int modeExtension) throws InvalidDataException {
  if (!CHANNEL_MODE_JOINT_STEREO.equals(channelMode)) {
   this.modeExtension = MODE_EXTENSION_NA;
  } else {
   if (layer == 1 || layer == 2) {
    switch (modeExtension) {
     case 0:
      this.modeExtension = MODE_EXTENSION_BANDS_4_31;
      return;
     case 1:
      this.modeExtension = MODE_EXTENSION_BANDS_8_31;
      return;
     case 2:
      this.modeExtension = MODE_EXTENSION_BANDS_12_31;
      return;
     case 3:
      this.modeExtension = MODE_EXTENSION_BANDS_16_31;
      return;
    }
   } else if (layer == 3) {
    switch (modeExtension) {
     case 0:
      this.modeExtension = MODE_EXTENSION_NONE;
      return;
     case 1:
      this.modeExtension = MODE_EXTENSION_INTENSITY_STEREO;
      return;
     case 2:
      this.modeExtension = MODE_EXTENSION_M_S_STEREO;
      return;
     case 3:
      this.modeExtension = MODE_EXTENSION_INTENSITY_M_S_STEREO;
      return;
    }
   }
   throw new InvalidDataException("Invalid mode extension in frame header");
  }
 }
