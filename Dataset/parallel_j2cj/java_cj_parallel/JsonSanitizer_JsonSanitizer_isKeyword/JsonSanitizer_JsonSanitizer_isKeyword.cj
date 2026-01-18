    private func isKeyword(start: Int64, end: Int64): Bool {
        let n = end - start
        if (n == 5) {
            return jsonish.slice(start, n) == FALSE_CHARS
        } else if (n == 4) {
            let substring = jsonish.slice(start, n)
            return substring == TRUE_CHARS || substring == NULL_CHARS
        }
        return false
    }