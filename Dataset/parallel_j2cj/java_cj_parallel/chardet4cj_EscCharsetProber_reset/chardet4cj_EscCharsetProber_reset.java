    @Override
 public final void reset() {
  this.state = ProbingState.DETECTING;
  for (int i = 0; i < this.codingSM.length; ++i) {
   this.codingSM[i].reset();
  }
  this.activeSM = this.codingSM.length;
  this.detectedCharset = null;
 }