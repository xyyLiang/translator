    private func canonicalizeNumber(start: Int64, end: Int64): Bool {
        let sanitizedJson = this.sanitizedJson.getOrThrow()
        elide(start, start)
        let sanStart = sanitizedJson.size()
        normalizeNumber(start, end)
        elide(end, end)
        let sanEnd = sanitizedJson.size()
        return canonicalizeNumber(sanitizedJson, sanStart, sanEnd)
    }