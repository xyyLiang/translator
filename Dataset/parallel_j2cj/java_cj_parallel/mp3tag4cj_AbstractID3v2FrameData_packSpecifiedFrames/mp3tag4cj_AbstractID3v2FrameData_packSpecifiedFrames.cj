    private func packSpecifiedFrames(bytes: Array<Int8>, offset: Int32, onlyId: Option<String>, notId: Option<String>): Int32 {
        var offsetNew = offset
        var sortFrameSets: HashMap<String, ID3v2FrameSet> = sortMap(frameSets)
        for ((_, frameSet) in sortFrameSets) {
            if ((onlyId == Option<String>.None || onlyId.getOrDefault({ => ""}) == frameSet.getId()) && (notId ==
                Option<String>.None || !(notId.getOrDefault({ => ""}) == frameSet.getId()))) {
                for (frame in frameSet.getFrames()) {
                    if (frame.getDataLength() > 0) {
                        var frameData: Array<Int8> = frame.toBytes()
                        BufferTools.copyIntoByteBuffer(frameData, 0, frameData.size, bytes, Int64(offsetNew))
                        offsetNew += Int32(frameData.size)
                    }
                }
            }
        }
        return offsetNew
    }