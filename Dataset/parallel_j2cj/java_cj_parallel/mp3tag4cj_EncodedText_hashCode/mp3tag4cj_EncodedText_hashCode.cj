    @OverflowWrapping
    public func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = 1
        result = prime * result + Int32(textEncoding)
        result = prime * result + Int32(value.toString().hashCode())
        return Int64(result)
    }