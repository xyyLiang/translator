    public func getConfidence(): Float32 { 

        var bestConfs: Float32 = 0.0
        var cfs: Float32 = 0.0

        if (this.state == ProbingState.FOUND_IT) {
            return 0.99
        } else if (this.state == ProbingState.NOT_ME) {
            return 0.01
        } else {
            for(probes in probers) {
          if (!probes.isActive()) {
           continue
          }
          cfs = probes.getConfidence()
                if (bestConfs < cfs) {
                    bestConfs = cfs
                    this.bestGuess = probes
                }
         }
        }

        return bestConfs
    }