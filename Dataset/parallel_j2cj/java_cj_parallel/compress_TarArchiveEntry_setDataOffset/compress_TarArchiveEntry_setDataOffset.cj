    public func setDataOffset(dataOffset: Int64): Unit {
        if (dataOffset < 0) {
            throw  IllegalArgumentException("The offset can not be smaller than 0")
        }
        this.dataOffset = dataOffset
    }