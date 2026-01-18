    func containsBlackPoint(a: Int64, b: Int64, fixed: Int64, horizontal: Bool): Bool {
        if (horizontal) {
            for (x in a..=b) {
                if (image.get(x, fixed)) {
                    return true
                }
            }
        } else {
            for (y in a..=b) {
                if (image.get(fixed, y)) {
                    return true
                }
            }
        }
        false
    }