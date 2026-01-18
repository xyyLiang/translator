    public open func isCompilation(): Bool {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_COMPILATION_OBSELETE
            } else {
                ID_COMPILATION
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None) {
            if (frameData.getOrThrow().getText() != Option<EncodedText>.None) {
                match (frameData.getOrThrow().getText()) {
                    case Some(x) => return "1" == x.toString().getOrDefault({ => ""})
                    case None => ()
                }
            }
        }
        return false;
    }