 public void handleData(final byte[] buf, int offset, int length) {
        if (this.done) {
            return;
        }
        
        if (length > 0) {
            this.gotData = true;
        }
        
        if (this.start) {
            this.start = false;
            if (length > 3) {
                String detectedBOM = detectCharsetFromBOM(buf, offset);                
                if (detectedBOM != null) {
                 this.detectedCharset = detectedBOM;
                    this.done = true;
                    return;
                }
            }
        } // if (start) end
        
        int maxPos = offset + length;
        for (int i=offset; i<maxPos; ++i) {
            int c = buf[i] & 0xFF;
            if ((c & 0x80) != 0 && c != 0xA0) {
                if (this.inputState != InputState.HIGHBYTE) {
                    this.inputState = InputState.HIGHBYTE;
                    
                    if (this.escCharsetProber != null) {
                        this.escCharsetProber = null;
                    }
                    
                    if (this.probers[0] == null) {
                        this.probers[0] = new MBCSGroupProber();
                    }
                    if (this.probers[1] == null) {
                        this.probers[1] = new SBCSGroupProber();
                    }
                    if (this.probers[2] == null) {
                        this.probers[2] = new Latin1Prober();
                    }
                }
            } else {
                if (this.inputState == InputState.PURE_ASCII &&
                    (c == 0x1B || (c == 0x7B && this.lastChar == 0x7E))) {
                    this.inputState = InputState.ESC_ASCII;
                }
                if (this.inputState == InputState.PURE_ASCII && onlyPrintableASCII) {
                 onlyPrintableASCII =
                   (c >= 0x20 && c <= 0x7e) // Printable characters 
                   || c == 0x0A  // New Line
                   || c == 0x0D  // Carriage return 
                   || c== 0x09;  // TAB
                }
                this.lastChar = buf[i];
            }
        } // for end
        
        CharsetProber.ProbingState st;
        if (this.inputState == InputState.ESC_ASCII) {
            if (this.escCharsetProber == null) {
                this.escCharsetProber = new EscCharsetProber();
            }
            st = this.escCharsetProber.handleData(buf, offset, length);
            if (st == CharsetProber.ProbingState.FOUND_IT || 0.99f == this.escCharsetProber.getConfidence()) {
                this.done = true;
                this.detectedCharset = this.escCharsetProber.getCharSetName();
            }
        } else if (this.inputState == InputState.HIGHBYTE) {
            for (int i=0; i<this.probers.length; ++i) {
                st = this.probers[i].handleData(buf, offset, length);
                if (st == CharsetProber.ProbingState.FOUND_IT) {
                    this.done = true;
                    this.detectedCharset = this.probers[i].getCharSetName();
                    return;
                }
            }
        } else { // pure ascii
            // do nothing
        }
    }
