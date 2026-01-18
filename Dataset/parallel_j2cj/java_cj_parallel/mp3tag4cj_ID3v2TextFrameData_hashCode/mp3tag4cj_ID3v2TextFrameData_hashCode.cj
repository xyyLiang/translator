    @OverflowWrapping
    public func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        if (text == Option<EncodedText>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(text.getOrThrow().hashCode())
        }
        return Int64(result)
    }