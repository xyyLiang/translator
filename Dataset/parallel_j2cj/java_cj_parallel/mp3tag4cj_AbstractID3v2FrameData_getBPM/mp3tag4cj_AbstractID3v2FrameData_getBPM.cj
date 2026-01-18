    public open func getBPM(): Option<Int32> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_BPM_OBSELETE
            } else {
                ID_BPM
            }
        )
        if (frameData == Option<ID3v2TextFrameData>.None || frameData.getOrThrow().getText() == Option<EncodedText>.None) {
            return Option<Int32>.Some(-1)
        }
        var bpmStr: Option<String> = frameData.getOrThrow().getText().getOrThrow().toString()
        try {
            match (bpmStr) {
                case Some(x) => return Option<Int32>.Some(Int32.parse(x))
                case None => return Option<Int32>.Some(-1)
            }
        } catch (e: Exception) {
            // try float as some utilities add BPM like 67.8, or 67,8
            match (bpmStr) {
                case Some(x) => return Option<Int32>.Some(Int32(Float32.parse(x.trim().replace(",", "."))))
                case None => return Option<Int32>.Some(-1)
            }
        }
    }