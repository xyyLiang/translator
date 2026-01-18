 public UniversalDetector(CharsetListener listener) {
        this.listener = listener;
        this.escCharsetProber = null;
        this.probers = new CharsetProber[3];
        
        reset();
    }