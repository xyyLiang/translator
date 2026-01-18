    func decodeRow2pairs(rowNumber: Int64, row: BitArray): ArrayList<ExpandedPair> {
        var done = false
        while (!done) {
            try {
                this.pairs.append(retrieveNextPair(row, this.pairs, rowNumber))
            } catch (nfe: NotFoundException) {
                if (this.pairs.isEmpty()) {
                    throw nfe
                }
                done = true
            }
        }
        if (checkChecksum()) {
            return this.pairs
        }

        let tryStackedDecode = !this.pairs.isEmpty()
        storeRow(rowNumber)
        if (tryStackedDecode) {
            var ps = checkRows(false)
            if (let Some(p) = ps) {
                return p
            }
            ps = checkRows(true)
            if (let Some(p) = ps) {
                return p
            }
        }

        throw NotFoundException()
    }
