 @Override
 public int hashCode() {
  final int prime = 31;
  int result = super.hashCode();
  result = prime * result + ((description == null) ? 0 : description.hashCode());
  result = prime * result + ((url == null) ? 0 : url.hashCode());
  return result;
 }