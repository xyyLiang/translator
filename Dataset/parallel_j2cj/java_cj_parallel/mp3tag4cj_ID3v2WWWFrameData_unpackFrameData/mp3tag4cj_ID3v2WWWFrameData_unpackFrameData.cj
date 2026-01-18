    @OverflowWrapping
    public override func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        if (description == Option<EncodedText>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(description.getOrThrow().hashCode())
        }
        if (url == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(url.getOrThrow().hashCode())
        }
        return Int64(result)
    }