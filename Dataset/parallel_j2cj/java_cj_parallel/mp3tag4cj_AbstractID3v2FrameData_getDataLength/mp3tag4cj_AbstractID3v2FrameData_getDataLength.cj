    public open func getDataLength(): Int32 {
        if (Int64(dataLength) == 0) {
            dataLength = calculateDataLength()
        }
        return dataLength
    }