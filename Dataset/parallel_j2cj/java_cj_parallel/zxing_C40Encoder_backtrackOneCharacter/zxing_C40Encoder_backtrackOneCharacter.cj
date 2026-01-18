    func backtrackOneCharacter(
        context: EncoderContext,
        buffer: StringBuilder,
        removed: StringBuilder,
        lastCharSize: Int64
    ): Int64 {
        let count = buffer.size
        buffer.remove((count - lastCharSize)..count)
        context.pos--
        let c = context.getCurrent()
        let lcs = encodeChar(c, removed)
        context.resetSymbolInfo()
        lcs
    }