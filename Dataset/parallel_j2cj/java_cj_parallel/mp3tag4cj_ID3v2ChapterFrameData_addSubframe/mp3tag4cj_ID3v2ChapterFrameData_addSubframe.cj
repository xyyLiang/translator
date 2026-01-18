    public func addSubframe(id: String, frame: AbstractID3v2FrameData): Unit {
        subframes.getOrThrow().append(ID3v2Frame(id, frame.toBytes()))
    }