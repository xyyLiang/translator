 private void setChannelMode(int channelMode) throws InvalidDataException {
  switch (channelMode) {
   case 0:
    this.channelMode = CHANNEL_MODE_STEREO;
    break;
   case 1:
    this.channelMode = CHANNEL_MODE_JOINT_STEREO;
    break;
   case 2:
    this.channelMode = CHANNEL_MODE_DUAL_MONO;
    break;
   case 3:
    this.channelMode = CHANNEL_MODE_MONO;
    break;
   default:
    throw new InvalidDataException("Invalid channel mode in frame header");
  }
 }