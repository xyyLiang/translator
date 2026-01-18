    public func getLength(): Int32 {
        var length: Int32 = 1
        length += 16
        if (id != Option<String>.None) {
            length += Int32(id.getOrThrow().size)
        }
        if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
            for (frame in subframes.getOrThrow()) {
                length += frame.getLength()
            }
        }
        return length
    }