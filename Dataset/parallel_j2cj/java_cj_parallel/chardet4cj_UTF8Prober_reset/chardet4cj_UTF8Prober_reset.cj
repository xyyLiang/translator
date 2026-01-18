    public func reset() {
        this.codingSM.reset()
        this.numOfMBChar = 0
        this.state = ProbingState.DETECTING
    }