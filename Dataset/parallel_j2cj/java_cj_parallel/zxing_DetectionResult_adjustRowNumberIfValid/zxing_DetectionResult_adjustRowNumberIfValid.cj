    static func adjustRowNumberIfValid(rowIndicatorRowNumber: Int64, invalidRowCounts: Int64, codeword: ?Codeword): Int64 {
        if (let Some(c) = codeword) {
            if (!c.hasValidRowNumber()) {
                if (c.isValidRowNumber(rowIndicatorRowNumber)) {
                    c.rowNumber = rowIndicatorRowNumber
                    return 0
                } else {
                    return invalidRowCounts + 1
                }
            }
        }
        invalidRowCounts
    }