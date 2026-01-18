    public func getLength(): Int32 {
        var length: Int32 = 3
        if (id != Option<String>.None) {
            length += Int32(id.getOrThrow().toRuneArray().size)
        }
        if (children != Option<Array<String>>.None) {
            length += Int32(children.getOrThrow().size)
            for (child in children.getOrThrow()) {
                length += Int32(child.toRuneArray().size)
            }
        }
        if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
            for (frame in subframes.getOrThrow()) {
                length += Int32(frame.getLength())
            }
        }
        return length
    }