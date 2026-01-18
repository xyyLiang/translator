  @Override
  protected void addWeightCode(StringBuilder buf, int weight) {
    buf.append('(');
    buf.append(this.firstAIdigits);
    buf.append(weight / 100000);
    buf.append(')');
  }