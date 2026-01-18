    public func nextState(c: Byte): Int32 { 
        let byteCls: Int32 = this.model.getClass(c)
        if (this.currentState == SMModel.START) {
            this.currentBytePos = 0
            this.currentCharLen = this.model.getCharLen(byteCls)
        }

        this.currentState = this.model.getNextState(byteCls, this.currentState)
        this.currentBytePos++

        return this.currentState
    }