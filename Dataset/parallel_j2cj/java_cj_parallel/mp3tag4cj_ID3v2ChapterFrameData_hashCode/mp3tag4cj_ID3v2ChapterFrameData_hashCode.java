 @Override
 public int hashCode() {
  final int prime = 31;
  int result = 1;
  result = prime * result + endOffset;
  result = prime * result + endTime;
  result = prime * result + ((id == null) ? 0 : id.hashCode());
  result = prime * result + startOffset;
  result = prime * result + startTime;
  result = prime * result
    + ((subframes == null) ? 0 : subframes.hashCode());
  return result;
 }