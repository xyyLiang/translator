 public final void reset() {
        this.done = false;
        this.start = true;
        this.detectedCharset = null;
        this.gotData = false;
        this.inputState = InputState.PURE_ASCII;
        this.lastChar = 0;
        
        if (this.escCharsetProber != null) {
            this.escCharsetProber.reset();
        }
        
        for (int i=0; i<this.probers.length; ++i) {
            if (this.probers[i] != null) {
                this.probers[i].reset();
            }
        }
    }