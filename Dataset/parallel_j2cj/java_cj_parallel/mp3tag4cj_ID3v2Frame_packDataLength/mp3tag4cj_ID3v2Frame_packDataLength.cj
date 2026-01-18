    protected open func packDataLength(): Array<Int8> {
        return BufferTools.packInteger(dataLength)
    }