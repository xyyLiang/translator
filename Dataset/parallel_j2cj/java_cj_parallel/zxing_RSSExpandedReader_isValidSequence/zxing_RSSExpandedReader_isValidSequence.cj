    static func isValidSequence(pairs: ArrayList<ExpandedPair>): Bool {
        for (sequence in FINDER_PATTERN_SEQUENCES) {
            if (pairs.size <= sequence.size) {
                var stop = true
                for (j in 0..pairs.size) {
                    if (pairs[j].finderPattern.getOrThrow().value != sequence[j]) {
                        stop = false
                        break
                    }
                }
                if (stop) {
                    return true
                }
            }
        }

        false
    }