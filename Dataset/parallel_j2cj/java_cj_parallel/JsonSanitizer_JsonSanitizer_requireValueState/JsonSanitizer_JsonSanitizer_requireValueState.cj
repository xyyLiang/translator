    private func requireValueState(pos: Int64, state: State, canBeKey: Bool): State {
        match(state) {
            case START_MAP | BEFORE_KEY => 
                if (canBeKey) {
                    return State.AFTER_KEY
                } else {
                    insert(pos, #""":"#)
                    return State.AFTER_VALUE
                }
            case AFTER_KEY => 
                insert(pos, ':')
                return State.AFTER_VALUE
            case BEFORE_VALUE => 
                return State.AFTER_VALUE
            case AFTER_VALUE => 
                if (canBeKey) {
                    insert(pos, ',')
                    return State.AFTER_KEY
                } else {
                    insert(pos, #","":"#)
                    return State.AFTER_VALUE
                }
            case START_ARRAY | BEFORE_ELEMENT => 
                return State.AFTER_ELEMENT
            case AFTER_ELEMENT => 
                if (bracketDepth == 0) {
                    throw UNBRACKETED_COMMA
                }
                insert(pos, ',')
                return State.AFTER_ELEMENT
        }
    }