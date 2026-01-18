    public func getRecordingTime(): Option<String> {
        match (extractTextFrameData(ID_RECTIME)) {
            case Some(x) =>
                match (x.getText()) {
                    case Some(y) => return y.toString()
                    case None => return Option<String>.None
                }
            case None => return Option<String>.None
        }
    }