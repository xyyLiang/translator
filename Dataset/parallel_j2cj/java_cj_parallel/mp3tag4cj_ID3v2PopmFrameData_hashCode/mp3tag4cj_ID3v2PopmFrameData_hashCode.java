 @Override
 public int hashCode() {
  final int prime = 31;
  int result = super.hashCode();
  result = prime * result + ((address == null) ? 0 : address.hashCode());
  result = prime * result + rating;
  return result;
 }