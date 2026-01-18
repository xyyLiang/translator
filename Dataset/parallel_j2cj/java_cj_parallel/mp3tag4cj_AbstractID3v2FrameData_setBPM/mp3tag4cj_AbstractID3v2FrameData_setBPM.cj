    public open func setBPM(bpm: Int32): Unit {
        if (bpm >= 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(bpm.toString())
            )
            addFrame(createFrame(ID_BPM.toString(), frameData.toBytes()), true)
        }
    }