    protected open func synchroniseAndUnpackFrameData(bytes: Array<Int8>): Unit {
        if (unsynchronisation && BufferTools.sizeSynchronisationWouldSubtract(bytes) > 0) {
            var synchronisedBytes: Array<Int8> = BufferTools.synchroniseBuffer(bytes)
            unpackFrameData(synchronisedBytes)
        } else {
            unpackFrameData(bytes)
        }
    }