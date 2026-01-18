    public func getCharSetName(): String {

        match (this.bestGuess) {
            case Some(_) => ()
            case None =>
                getConfidence()
                match (this.bestGuess) { 
                    case Some(_) => ()
                    case None =>
                        this.bestGuess = probers.get(0)
                }
        }
  return this.bestGuess.getOrThrow().getCharSetName()
    }