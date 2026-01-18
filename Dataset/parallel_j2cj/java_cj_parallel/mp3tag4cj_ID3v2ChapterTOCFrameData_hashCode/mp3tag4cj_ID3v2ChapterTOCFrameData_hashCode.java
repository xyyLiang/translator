 @Override
 public int hashCode() {
  final int prime = 31;
  int result = super.hashCode();
  result = prime * result + Arrays.hashCode(children);
  result = prime * result + ((id == null) ? 0 : id.hashCode());
  result = prime * result + (isOrdered ? 1231 : 1237);
  result = prime * result + (isRoot ? 1231 : 1237);
  result = prime * result
    + ((subframes == null) ? 0 : subframes.hashCode());
  return result;
 }