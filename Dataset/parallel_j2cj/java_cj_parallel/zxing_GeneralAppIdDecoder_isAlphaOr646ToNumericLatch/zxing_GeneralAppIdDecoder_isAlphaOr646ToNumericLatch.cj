    func isAlphaOr646ToNumericLatch(pos: Int64): Bool {
        if (pos + 3 > this.information.size) {
            return false
        }

        for (i in pos..(pos + 3)) {
            if (this.information.get(i)) {
                return false
            }
        }
        true
    }