    public func getLength(): Int32 {
        var length: Int32 = 4
        if (description != Option<EncodedText>.None) {
            length += Int32(description.getOrThrow().toBytes(true, true).size)
        } else {
            if (comment != Option<EncodedText>.None) {
                length += Int32(comment.getOrThrow().getTerminator().size)
            } else {
                length += 1
            }
        }
        if (comment != Option<EncodedText>.None) {
            length += Int32(comment.getOrThrow().toBytes(true, false).size)
        }
        return length
    }
