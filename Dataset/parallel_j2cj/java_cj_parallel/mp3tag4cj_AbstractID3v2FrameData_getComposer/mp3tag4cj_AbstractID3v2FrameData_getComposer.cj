    public open func getComposer(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_COMPOSER_OBSELETE
            } else {
                ID_COMPOSER
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None) {
            if (frameData.getOrThrow().getText() != Option<EncodedText>.None) {
                return frameData.getOrThrow().getText().getOrThrow().toString().getOrDefault({ => ""})
            }
        }
        return Option<String>.None
    }