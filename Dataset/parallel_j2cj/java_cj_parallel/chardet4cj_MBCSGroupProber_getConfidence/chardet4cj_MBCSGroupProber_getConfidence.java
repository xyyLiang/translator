    @Override
 public float getConfidence() {
        float bestConf = 0.0f;
        float cf;

        if (this.state == ProbingState.FOUND_IT) {
            return 0.99f;
        } else if (this.state == ProbingState.NOT_ME) {
            return 0.01f;
        } else {
         for(CharsetProber prober: probers) {
          if (!prober.isActive()) {
           continue;
          }
          cf = prober.getConfidence();
                if (bestConf < cf) {
                    bestConf = cf;
                    this.bestGuess = prober;
                }
         }
        }

        return bestConf;
    }