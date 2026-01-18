 public float getConfidence() {
        float unlike = 0.99f;
        
        if (this.numOfMBChar < 6) {
            for (int i=0; i<this.numOfMBChar; ++i) {
                unlike *= ONE_CHAR_PROB;
            }
            return (1.0f - unlike);
        } else {
            return 0.99f;
        }
    }