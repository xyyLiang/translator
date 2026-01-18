    public func toString(): String {
        return "[InsertDelta, position: ${getOriginal().getPosition()}" + ", lines: ${getRevised().getLines()}" + "]"
    }