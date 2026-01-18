    private InputEdge(char c, ECIEncoderSet encoderSet, int encoderIndex, InputEdge previous, int fnc1) {
      this.c = c == fnc1 ? 1000 : c;
      this.encoderIndex = encoderIndex;
      this.previous = previous;

      int size = this.c == 1000 ? 1 : encoderSet.encode(c, encoderIndex).length;
      int previousEncoderIndex = previous == null ? 0 : previous.encoderIndex;
      if (previousEncoderIndex != encoderIndex) {
        size += COST_PER_ECI;
      }
      if (previous != null) {
        size += previous.cachedTotalSize;
      }
      this.cachedTotalSize = size;
    }