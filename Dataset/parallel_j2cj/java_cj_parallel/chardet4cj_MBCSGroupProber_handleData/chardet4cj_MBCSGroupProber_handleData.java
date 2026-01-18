    @Override
 public ProbingState handleData(byte[] buf, int offset, int length) {
        ProbingState st;
        
        boolean keepNext = true;
        byte[] highbyteBuf = new byte[length];
        int highpos = 0;

        int maxPos = offset + length;
        for (int i=offset; i<maxPos; ++i) {
            if ((buf[i] & 0x80) != 0) {
                highbyteBuf[highpos++] = buf[i];
                keepNext = true;
            } else {
                //if previous is highbyte, keep this even it is a ASCII
                if (keepNext) {
                    highbyteBuf[highpos++] = buf[i];
                    keepNext = false;
                }
            }
        }
        
        for(CharsetProber prober: this.probers) {
         if (!prober.isActive()) {
          continue;
         }
         st = prober.handleData(highbyteBuf, 0, highpos);
         if (st == ProbingState.FOUND_IT || 0.99f == prober.getConfidence()) {
                this.bestGuess = prober;
                this.state = ProbingState.FOUND_IT;
                break;
            } else if (st == ProbingState.NOT_ME) {
                prober.setActive(false);
                this.activeNum--;
                if (this.activeNum <= 0) {
                    this.state = ProbingState.NOT_ME;
                    break;
                }
            }
        }
        
        return this.state;
    }