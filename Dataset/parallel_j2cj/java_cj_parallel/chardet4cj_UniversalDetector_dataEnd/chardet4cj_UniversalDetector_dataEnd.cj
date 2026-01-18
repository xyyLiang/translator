    public func dataEnd() {
        if (!this.gotData) {
            return
        }
        
        if (!this.detectedCharset.isEmpty()) {
            this.done = true
            match (this.listener) {
                case None => ()
                case Some(_) => this.listener.getOrThrow().report(this.detectedCharset)
            }
            return
        }
        if (this.inputState == InputState.HIGHBYTE) {
            var proberConfidence: Float32 = 0.0
            var maxProberConfidence: Float32 = 0.0
            var maxProber: Int32 = 0
            
            for(i in 0..this.probers.size) {
                proberConfidence = this.probers[i].getConfidence()
                if (proberConfidence > maxProberConfidence) {
                    maxProberConfidence = proberConfidence
                    maxProber = Int32(i)
                }
            }
            
            if (maxProberConfidence > MINIMUM_THRESHOLD) {
                this.detectedCharset = this.probers[Int64(maxProber)].getCharSetName()
                match (this.listener) {
                    case None => ()
                    case Some(_) => this.listener.getOrThrow().report(this.detectedCharset)
                }
            }

        } else if (this.inputState == InputState.PURE_ASCII && this.onlyPrintableASCII) {
         this.detectedCharset = Constants.CHARSET_US_ASCCI
        }
    }