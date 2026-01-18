    static func isPartialRow(pairs: Iterable<ExpandedPair>, rows: Iterable<ExpandedRow>): Bool {
        for (r in rows) {
            var allFound = true
            for (p in pairs) {
                var found = false
                for (pp in r.pairs) {
                    if (p == pp) {
                        found = true
                        break
                    }
                }
                if (!found) {
                    allFound = false
                    break
                }
            }
            if (allFound) {
                return true
            }
        }
        false
    }