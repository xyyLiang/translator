    private func elide(start: Int64, end: Int64): Unit {
        match(sanitizedJson) {
            case Some(val) => val
            case None =>
                let val = CharArrayList(jsonish.size() + 16)
                sanitizedJson = val
                val
        }.append(jsonish.slice(cleaned, start-cleaned))
        cleaned = end
    }