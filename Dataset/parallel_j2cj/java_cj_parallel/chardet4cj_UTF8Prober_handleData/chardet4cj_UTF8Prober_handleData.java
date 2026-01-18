 public ProbingState handleData(final byte[] buf, int offset, int length) {
        int codingState;

        int maxPos = offset + length;
        for (int i=offset; i<maxPos; ++i) {
            codingState = this.codingSM.nextState(buf[i]);
            if (codingState == SMModel.ERROR) {
                this.state = ProbingState.NOT_ME;
                break;
            }
            if (codingState == SMModel.ITSME) {
                this.state = ProbingState.FOUND_IT;
                break;
            }
            if (codingState == SMModel.START) {
                if (this.codingSM.getCurrentCharLen() >= 2) {
                    ++this.numOfMBChar;
                }
            }
        }
        
        if (this.state == ProbingState.DETECTING) {
            if (getConfidence() > SHORTCUT_THRESHOLD) {
                this.state = ProbingState.FOUND_IT;
            }
        }
        
        return this.state;
    }
