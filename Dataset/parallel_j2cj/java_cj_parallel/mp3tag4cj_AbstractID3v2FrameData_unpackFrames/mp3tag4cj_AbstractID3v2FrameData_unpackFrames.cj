    protected open func unpackFrames(bytesIn: Array<Int8>, offset: Int32, framesLength: Int32): Int32 {
        var currentOffsetTmp: Int32 = offset
        while (Int64(currentOffsetTmp) <= Int64(framesLength)) {
            var frameTmp: ID3v2Frame
            try {
                frameTmp = createFrame(bytesIn, currentOffsetTmp)
                addFrame(frameTmp, false)
                currentOffsetTmp += frameTmp.getLength()
            } catch (e: Exception) {
                break
            }
        }
        return currentOffsetTmp
    }