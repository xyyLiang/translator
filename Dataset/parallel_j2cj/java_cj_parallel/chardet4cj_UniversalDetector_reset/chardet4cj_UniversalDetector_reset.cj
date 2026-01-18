    public func reset() {
        this.done = false;
        this.start = true;
        this.detectedCharset = ""
        this.gotData = false;
        this.inputState = InputState.PURE_ASCII;
        this.lastChar = 0
        match (this.escCharsetProber) {
            case None => ()
            case Some(_) => this.escCharsetProber.getOrThrow().reset()
        }
        
        for (i in 0..this.probers.size) {
            if (!this.probers.isEmpty()) {
                this.probers[i].reset()
            }
        }
    }