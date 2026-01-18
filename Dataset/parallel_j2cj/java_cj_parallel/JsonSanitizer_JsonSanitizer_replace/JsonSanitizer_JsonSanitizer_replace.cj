    private func replace(start: Int64, end: Int64, ch: Char): Unit {
        elide(start, end)
        sanitizedJson.getOrThrow().append(ch)
    }