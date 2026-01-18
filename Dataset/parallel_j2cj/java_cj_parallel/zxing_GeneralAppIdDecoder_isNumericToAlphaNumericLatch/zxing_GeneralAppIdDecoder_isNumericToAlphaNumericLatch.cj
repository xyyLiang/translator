    func isNumericToAlphaNumericLatch(pos: Int64): Bool {
        if (pos + 1 > this.information.size) {
            return false
        }

        for (i in 0..4) {
            if (i + pos >= this.information.size) {
                break
            }
            if (this.information.get(pos + i)) {
                return false
            }
        }
        true
    }