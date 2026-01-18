    func checkRows(reverse: Bool): ?ArrayList<ExpandedPair> {
        if (this.rows.size > 25) {
            this.rows.clear()
            return None
        }

        this.pairs.clear()
        if (reverse) {
            this.rows.reverse()
        }

        var ps: ?ArrayList<ExpandedPair> = None
        try {
            ps = checkRows(ArrayList<ExpandedRow>(), 0)
        } catch (e: NotFoundException) {}
        if (reverse) {
            this.rows.reverse()
        }

        ps
    }
