    public func hashCode(): Int64{
        return Int64(_address) ^ Int64(rightShift(_address,32))
    }