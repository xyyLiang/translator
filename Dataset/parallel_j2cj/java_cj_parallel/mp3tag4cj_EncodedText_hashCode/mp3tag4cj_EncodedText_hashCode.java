 @Override
 public int hashCode() {
  final int prime = 31;
  int result = 1;
  result = prime * result + textEncoding;
  result = prime * result + Arrays.hashCode(value);
  return result;
 }