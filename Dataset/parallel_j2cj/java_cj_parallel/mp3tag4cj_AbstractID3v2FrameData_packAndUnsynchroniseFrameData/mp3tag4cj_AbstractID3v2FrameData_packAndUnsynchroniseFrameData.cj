    protected open func packAndUnsynchroniseFrameData(): Array<Int8> {
        var bytes: Array<Int8> = packFrameData()
        if (unsynchronisation && BufferTools.sizeUnsynchronisationWouldAdd(bytes) > 0) {
            return BufferTools.unsynchroniseBuffer(bytes)
        }
        return bytes
    }