 @Override
 public int hashCode() {
  final int prime = 31;
  int result = super.hashCode();
  result = prime * result
    + ((description == null) ? 0 : description.hashCode());
  result = prime * result + Arrays.hashCode(imageData);
  result = prime * result
    + ((mimeType == null) ? 0 : mimeType.hashCode());
  result = prime * result + pictureType;
  return result;
 }