    private func endOfDigitRun(start: Int64, limit: Int64): Int64 {
        for (end in start..limit) {
            let ch = jsonish.charAt(end)
            if (!('0' <= ch && ch <= '9')) {
                return end
            }
        }
        return limit
    }