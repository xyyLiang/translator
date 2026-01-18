    public func getLength(): Int32 {
        var length: Int32 = 1
        if (description != Option<EncodedText>.None) {
            length += Int32(description.getOrThrow().toBytes(true, true).size)
        } else {
            length++
        }
        if (url != Option<String>.None) {
            length += Int32(url.getOrThrow().toArray().size)
        }
        return length
    }