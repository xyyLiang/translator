    public func getNextState(cls: Int32, currentState: Int32): Int32 {
        return this.stateTable.unpack(currentState * this.classFactor + cls)
    }