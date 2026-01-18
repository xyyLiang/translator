    public open func getKey(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_KEY_OBSELETE
            } else {
                ID_KEY
            }
        )
        if (frameData == Option<ID3v2TextFrameData>.None || frameData.getOrThrow().getText() == Option<EncodedText>.None) {
            return Option<String>.None
        }
        return frameData.getOrThrow().getText().getOrThrow().toString()
    }
