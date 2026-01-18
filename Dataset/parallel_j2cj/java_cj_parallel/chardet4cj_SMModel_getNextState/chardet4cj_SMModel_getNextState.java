 public int getNextState(int cls, int currentState) {
        return this.stateTable.unpack(currentState * this.classFactor + cls);
    }