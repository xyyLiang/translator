    public func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {_ => 0})
        if (url != Option<String>.None && url.getOrThrow().size > 0) {
            try {
                BufferTools.stringIntoByteBuffer(url.getOrThrow(), 0, url.getOrThrow().size, bytes, 0)
            } catch (e: Exception) {}
        }
        return bytes
    }