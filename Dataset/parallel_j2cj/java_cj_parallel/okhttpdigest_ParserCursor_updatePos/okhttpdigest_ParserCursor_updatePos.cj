    public func updatePos(pos: Int32) {
        if(pos < this.lowerBound) {
            throw IndexOutOfBoundsException()
        } else if(pos > this.upperBound) {
            throw IndexOutOfBoundsException()
        } else {
            this.pos = pos
        }
    }