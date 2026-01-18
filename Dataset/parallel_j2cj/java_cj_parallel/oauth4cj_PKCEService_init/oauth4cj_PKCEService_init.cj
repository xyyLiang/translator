    public init(numberOFOctets: Int32) {
        if (numberOFOctets < 0) {
            throw OAuth4cjException("The number of octets cannot be negative")
        }
        this.numberOFOctets = numberOFOctets
    }