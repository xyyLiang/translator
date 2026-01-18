    public func toString(): String {
        return "[ChangeDelta, position: ${getOriginal().getPosition()}" + ", lines: ${getOriginal().getLines()}" + " to ${getRevised().getLines()}" + "]"
    }