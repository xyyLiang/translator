    public func getRangeLeft():Int64{
        return startOffset + currentOffset.load()
    }