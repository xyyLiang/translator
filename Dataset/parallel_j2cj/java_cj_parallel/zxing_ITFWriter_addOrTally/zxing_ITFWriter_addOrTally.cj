    static func addOrTally(possiblePairs: ArrayList<Pair>, pair: ?Pair) {
        if (let Some(p) = pair) {
            var found = false
            for (other in possiblePairs) {
                if (other.value == p.value) {
                    other.incrementCount()
                    found = true
                    break
                }
            }
            if (!found) {
                possiblePairs.append(p)
            }
        }
    }