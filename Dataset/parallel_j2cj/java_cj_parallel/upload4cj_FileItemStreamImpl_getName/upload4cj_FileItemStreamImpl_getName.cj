    public override func getName(): Option<String> {
        return Streams.checkFileName(name)
    }