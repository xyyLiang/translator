    func storeRow(rowNumber: Int64) {
        var insertPos = 0
        var prevIsSame = false
        var nextIsSame = false
        while (insertPos < this.rows.size) {
            let erow = this.rows[insertPos]
            if (erow.rowNumber > rowNumber) {
                nextIsSame = erow.isEquivalent(this.pairs)
                break
            }
            prevIsSame = erow.isEquivalent(this.pairs)
            insertPos++
        }
        if (nextIsSame || prevIsSame) {
            return
        }

        if (isPartialRow(this.pairs, this.rows)) {
            return
        }

        this.rows.insert(insertPos, ExpandedRow(this.pairs, rowNumber))

        removePartialRows(this.pairs, this.rows)
    }