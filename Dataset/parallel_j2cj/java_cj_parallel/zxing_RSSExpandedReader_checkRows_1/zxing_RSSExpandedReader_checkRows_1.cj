    func checkRows(collectedRows: ArrayList<ExpandedRow>, currentRow: Int64): ?ArrayList<ExpandedPair> {
        for (i in currentRow..rows.size) {
            let row = rows[i]
            this.pairs.clear()
            for (collectedRow in collectedRows) {
                this.pairs.appendAll(collectedRow.pairs)
            }
            this.pairs.appendAll(row.pairs)

            if (isValidSequence(this.pairs)) {
                if (checkChecksum()) {
                    return this.pairs
                }

                let rs = ArrayList<ExpandedRow>(collectedRows)
                rs.append(row)
                try {
                    return checkRows(rs, i + 1)
                } catch (e: NotFoundException) {}
            }
        }

        throw NotFoundException()
    }
