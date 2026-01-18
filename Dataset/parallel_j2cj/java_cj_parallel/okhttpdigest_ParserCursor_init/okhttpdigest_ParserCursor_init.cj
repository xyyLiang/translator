    public init(lowerBound: Int32, upperBound: Int32) {
        if(lowerBound < 0) {
            throw IndexOutOfBoundsException("Lower bound cannot be negative");
        } else if(lowerBound > upperBound) {
            throw IndexOutOfBoundsException("Lower bound cannot be greater then upper bound");
        } else {
            this.lowerBound = lowerBound
            this.upperBound = upperBound
            this.pos = lowerBound
        }
    }