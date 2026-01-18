    public open func getCopyright(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_COPYRIGHT_OBSELETE
            } else {
                ID_COPYRIGHT
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None) {
            if (frameData.getOrThrow().getText() != Option<EncodedText>.None) {
                return frameData.getOrThrow().getText().getOrThrow().toString().getOrDefault({ => ""})
            }
        }
        return Option<String>.None
    }