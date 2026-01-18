    static func toIntArray(list: ?Collection<Int64>): Array<Int64> {
        if (let Some(l) = list) {
            if (l.isEmpty()) {
                EMPTY_INT_ARRAY
            } else {
                l.toArray()
            }
        } else {
            EMPTY_INT_ARRAY
        }
    }