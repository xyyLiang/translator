    func module(orow: Int64, ocol: Int64, pos: Int64, bit: Int64) {
        var row = orow
        var col = ocol
        if (row < 0) {
            row += numrows
            col += 4 - ((numrows + 4) % 8)
        }
        if (col < 0) {
            col += numcols
            row += 4 - ((numcols + 4) % 8)
        }

        var v = UInt32(codewords.charAt(pos))
        v &= 1 << (8 - bit)
        setBit(col, row, v != 0)
    }