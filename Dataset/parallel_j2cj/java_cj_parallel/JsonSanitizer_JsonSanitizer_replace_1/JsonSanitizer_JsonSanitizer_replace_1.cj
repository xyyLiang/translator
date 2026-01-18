    private func replace(start: Int64, end: Int64, s: String): Unit {
        elide(start, end)
        sanitizedJson.getOrThrow().append(s)
    }