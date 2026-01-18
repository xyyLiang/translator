    public func getLength(): Int32 {
        var length: Int32 = 0
        if (url != Option<String>.None) {
            length = Int32(url.getOrThrow().toArray().size)
        }
        return length
    }