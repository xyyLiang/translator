    @OverflowWrapping
    public func getLength(): Int32 {
        var length: Int32 = 1
        if (text != Option<EncodedText>.None) {
            length += Int32(text.getOrThrow().toBytes(true, false).size)
        }
        return length
    }