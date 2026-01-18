    public func setEmphasis(emphasis: Int32): Unit {
        match (emphasis) {
            case 0 => this.emphasis = EMPHASIS_NONE
            case 1 => this.emphasis = EMPHASIS__50_15_MS
            case 3 => this.emphasis = EMPHASIS_CCITT_J_17
            case _ => throw InvalidDataException("Invalid emphasis in frame header")
        }
    }