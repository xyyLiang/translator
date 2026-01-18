    func place() {
        var pos = 0
        var row = 4
        var col = 0

        do {
            if ((row == numrows) && (col == 0)) {
                corner1(pos)
                pos++
            }
            if ((row == numrows - 2) && (col == 0) && ((numcols % 4) != 0)) {
                corner2(pos)
                pos++
            }
            if ((row == numrows - 2) && (col == 0) && (numcols % 8 == 4)) {
                corner3(pos)
                pos++
            }
            if ((row == numrows + 4) && (col == 2) && ((numcols % 8) == 0)) {
                corner4(pos)
                pos++
            }

            do {
                if ((row < numrows) && (col >= 0) && noBit(col, row)) {
                    utah(row, col, pos)
                    pos++
                }
                row -= 2
                col += 2
            } while (row >= 0 && (col < numcols))
            row++
            col += 3

            do {
                if ((row >= 0) && (col < numcols) && noBit(col, row)) {
                    utah(row, col, pos)
                    pos++
                }
                row += 2
                col -= 2
            } while ((row < numrows) && (col >= 0))
            row += 3
            col++
        } while ((row < numrows) || (col < numcols))

        if (noBit(numcols - 1, numrows - 1)) {
            setBit(numcols - 1, numrows - 1, true)
            setBit(numcols - 2, numrows - 2, true)
        }
    }