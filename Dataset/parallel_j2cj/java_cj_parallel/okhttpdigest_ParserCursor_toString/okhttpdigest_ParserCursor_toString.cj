    public func toString(): String {
        var buffer: StringBuilder = StringBuilder()
        buffer.append('[')
        buffer.append(this.lowerBound)
        buffer.append('>')
        buffer.append(this.pos)
        buffer.append('>')
        buffer.append(this.upperBound)
        buffer.append(']')
        return buffer.toString()
    }