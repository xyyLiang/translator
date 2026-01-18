    public func handleData(buf: Array<Byte>, offset: Int32, length: Int32): ProbingState {
        if (buf.size == 0) {
            throw ChardetException("this buf is empty")
        }
        var codingState: Int32 = 0

        let maxPos: Int32 = offset + length
        if (maxPos <= 0) {
            throw ChardetException("this length is null")
        }
        for (i in offset..maxPos) {
            codingState = this.codingSM.nextState(buf[Int64(i)])
            if (codingState == SMModel.ERROR) {
                this.state = ProbingState.NOT_ME
                break
            }
            if (codingState == SMModel.ITSME) {
                this.state = ProbingState.FOUND_IT
                break
            }
            if (codingState == SMModel.START) {
                if (this.codingSM.getCurrentCharLen() >= 2) {
                    this.numOfMBChar++
                }
            }
        }
        if (this.state == ProbingState.DETECTING) {
            if (this.getConfidence() > CharsetProber.SHORTCUT_THRESHOLD) {
                this.state = ProbingState.FOUND_IT
            }
        }
        
        return this.state
    }