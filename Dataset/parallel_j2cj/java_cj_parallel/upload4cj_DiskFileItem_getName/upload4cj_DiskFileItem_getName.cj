    public override func getName(): String {
        return Streams.checkFileName(this.fileName).getOrThrow()
    }