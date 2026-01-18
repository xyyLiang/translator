    public func rotate180() {
        var topRow = BitArray(width)
        var bottomRow = BitArray(width)
        let maxHeight = (height + 1) / 2
        for (i in 0..maxHeight) {
            topRow = row(i, topRow)
            let bottomRowIndex = height - 1 - i
            bottomRow = row(bottomRowIndex, bottomRow)
            topRow.reverse()
            bottomRow.reverse()
            append(i, bottomRow)
            append(bottomRowIndex, topRow)
        }
    }