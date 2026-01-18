    @Override
 public String getCharSetName() {
  if (this.bestGuess == null) {
   getConfidence();
   if (this.bestGuess == null) {
    this.bestGuess = probers.get(0);
   }
  }
  return this.bestGuess.getCharSetName();
 }