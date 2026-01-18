    func readFormatInformation(): FormatInformation {
        if (let Some(d) = this.parsedFormatInfo) {
            return d
        }

        var formatInfoBits1 = 0
        for (i in 0..6) {
            formatInfoBits1 = copyBit(i, 8, formatInfoBits1)
        }

        formatInfoBits1 = copyBit(7, 8, formatInfoBits1)
        formatInfoBits1 = copyBit(8, 8, formatInfoBits1)
        formatInfoBits1 = copyBit(8, 7, formatInfoBits1)

        for (j in 5..=0 : -1) {
            formatInfoBits1 = copyBit(8, j, formatInfoBits1)
        }

        let dimension = this.bitMatrix.height
        var formatInfoBits2 = 0
        for (j in (dimension - 1)..=(dimension - 7) : -1) {
            formatInfoBits2 = copyBit(8, j, formatInfoBits2)
        }
        for (i in (dimension - 8)..dimension) {
            formatInfoBits2 = copyBit(i, 8, formatInfoBits2)
        }

        this.parsedFormatInfo = decodeFormatInformation(formatInfoBits1, formatInfoBits2)
        if (let Some(d) = this.parsedFormatInfo) {
            return d
        }

        throw FormatException()
    }