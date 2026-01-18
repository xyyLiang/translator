  private State requireValueState(int pos, State state, boolean canBeKey)
    throws UnbracketedComma {
    switch (state) {
      case START_MAP: case BEFORE_KEY:
        if (canBeKey) {
          return State.AFTER_KEY;
        } else {
          insert(pos, "\"\":");
          return State.AFTER_VALUE;
        }
      case AFTER_KEY:
        insert(pos, ':');
        return State.AFTER_VALUE;
      case BEFORE_VALUE:
        return State.AFTER_VALUE;
      case AFTER_VALUE:
        if (canBeKey) {
          insert(pos, ',');
          return State.AFTER_KEY;
        } else {
          insert(pos, ",\"\":");
          return State.AFTER_VALUE;
        }
      case START_ARRAY: case BEFORE_ELEMENT:
        return State.AFTER_ELEMENT;
      case AFTER_ELEMENT:
        if (bracketDepth == 0) { throw UNBRACKETED_COMMA; }
        insert(pos, ',');
        return State.AFTER_ELEMENT;
    }
    throw new AssertionError();
  }