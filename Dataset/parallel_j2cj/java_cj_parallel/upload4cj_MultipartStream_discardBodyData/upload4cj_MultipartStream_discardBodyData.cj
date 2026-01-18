    public func discardBodyData(): Int64 {
        return readBodyData(Option<OutputStream>.None)
    }