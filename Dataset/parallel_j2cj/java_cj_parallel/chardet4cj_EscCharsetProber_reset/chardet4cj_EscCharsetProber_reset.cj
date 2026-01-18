    public func reset() {
        this.state = ProbingState.DETECTING
  for (i in 0..this.codingSM.size) {
   this.codingSM[i].reset()
  }
  this.activeSM = Int32(this.codingSM.size)
  this.detectedCharset = ""
    }