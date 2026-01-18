    static func arrayContains(array: ?Array<Char>, key: Char): Bool {
        if (let Some(arr) = array) {
            for (c in arr) {
                if (c == key) {
                    return true
                }
            }
        }
        false
    }
