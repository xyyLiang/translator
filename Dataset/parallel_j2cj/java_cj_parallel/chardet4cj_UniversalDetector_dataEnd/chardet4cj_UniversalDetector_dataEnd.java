 public void dataEnd() {
        if (!this.gotData) {
            return;
        }
        
        if (this.detectedCharset != null) {
            this.done = true;
            if (this.listener != null) {
                this.listener.report(this.detectedCharset);
            }
            return;
        }
        
        if (this.inputState == InputState.HIGHBYTE) {
            float proberConfidence;
            float maxProberConfidence = 0.0f;
            int maxProber = 0;
            
            for (int i=0; i<this.probers.length; ++i) {
                proberConfidence = this.probers[i].getConfidence();
                if (proberConfidence > maxProberConfidence) {
                    maxProberConfidence = proberConfidence;
                    maxProber = i;
                }
            }
            
            if (maxProberConfidence > MINIMUM_THRESHOLD) {
                this.detectedCharset = this.probers[maxProber].getCharSetName();
                if (this.listener != null) {
                    this.listener.report(this.detectedCharset);
                }
            }
        } else if (this.inputState == InputState.ESC_ASCII) {
            // do nothing
        } else if (this.inputState == InputState.PURE_ASCII && this.onlyPrintableASCII) {
         this.detectedCharset = CHARSET_US_ASCII;
        }
        else {
            // do nothing
        }
    }
   