    static func removePartialRows(pairs: ArrayList<ExpandedPair>, rows: ArrayList<ExpandedRow>) {
        let iterator = rows.iterator()
        var i = 0
        while (true) {
            if (let Some(r) = iterator.next()) {
                if (r.pairs.size != pairs.size) {
                    var allFound = true
                    for (p in r.pairs) {
                        if (!pairs.contains(p)) {
                            allFound = false
                            break
                        }
                    }
                    if (allFound) {
                        rows.remove(i)
                    }
                }
            } else {
                break
            }
        }
    }