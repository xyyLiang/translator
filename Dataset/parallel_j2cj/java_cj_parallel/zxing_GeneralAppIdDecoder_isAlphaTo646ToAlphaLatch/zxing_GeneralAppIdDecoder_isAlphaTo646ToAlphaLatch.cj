    func isAlphaTo646ToAlphaLatch(pos: Int64): Bool {
        if (pos + 1 > this.information.size) {
            return false
        }

        for (i in 0..4) {
            if (i + pos >= this.information.size) {
                break
            }
            if (i == 2) {
                if (!this.information.get(pos + 2)) {
                    return false
                }
            } else if (this.information.get(pos + i)) {
                return false
            }
        }

        true
    }