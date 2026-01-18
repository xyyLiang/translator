 private void setLayer(int layer) throws InvalidDataException {
  switch (layer) {
   case 1:
    this.layer = 3;
    break;
   case 2:
    this.layer = 2;
    break;
   case 3:
    this.layer = 1;
    break;
   default:
    throw new InvalidDataException("Invalid mpeg layer description in frame header");
  }
 }