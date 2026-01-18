 private void setVersion(int version) throws InvalidDataException {
  switch (version) {
   case 0:
    this.version = MPEG_VERSION_2_5;
    break;
   case 2:
    this.version = MPEG_VERSION_2_0;
    break;
   case 3:
    this.version = MPEG_VERSION_1_0;
    break;
   default:
    throw new InvalidDataException("Invalid mpeg audio version in frame header");
  }
 }