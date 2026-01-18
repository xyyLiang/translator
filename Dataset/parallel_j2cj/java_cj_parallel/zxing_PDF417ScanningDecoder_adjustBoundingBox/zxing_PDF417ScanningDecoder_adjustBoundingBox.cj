    static func adjustBoundingBox(rowIndicatorColumn: ?DetectionResultRowIndicatorColumn): ?BoundingBox {
        if (let Some(r) = rowIndicatorColumn) {
            let rowHeights = r.getRowHeights()
            if (let Some(rh) = rowHeights) {
                let maxRowHeight = getMax(rh)
                var missingStartRows = 0
                for (rowHeight in rh) {
                    missingStartRows += maxRowHeight - rowHeight
                    if (rowHeight > 0) {
                        break
                    }
                }
                let codewords = r.codewords
                var row = 0
                while (missingStartRows > 0 && if (let None = codewords[row]) {
                        true
                    } else {
                        false
                    }) {
                    missingStartRows--
                    row++
                }
                var missingEndRows = 0
                for (row in (rh.size - 1)..=0 : -1) {
                    missingEndRows += maxRowHeight - rh[row]
                    if (rh[row] > 0) {
                        break
                    }
                }
                row = codewords.size - 1
                while (missingEndRows > 0 && if (let None = codewords[row]) {
                        true
                    } else {
                        false
                    }) {
                    missingEndRows--
                    row--
                }
                r.boundingBox.addMissingRows(missingStartRows, missingEndRows, r.isLeft)
            } else {
                None
            }
        } else {
            None
        }
    }