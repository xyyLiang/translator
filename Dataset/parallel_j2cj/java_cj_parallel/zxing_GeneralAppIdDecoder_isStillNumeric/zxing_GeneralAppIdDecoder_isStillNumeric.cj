    func isStillNumeric(pos: Int64): Bool {
        if (pos + 7 > this.information.size) {
            return pos + 4 <= this.information.size
        }

        for (i in pos..(pos + 3)) {
            if (this.information.get(i)) {
                return true
            }
        }

        this.information.get(pos + 3)
    }