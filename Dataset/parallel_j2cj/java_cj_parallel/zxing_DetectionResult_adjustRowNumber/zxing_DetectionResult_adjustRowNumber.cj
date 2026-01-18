    static func adjustRowNumber(codeword: Codeword, otherCodeword: ?Codeword): Bool {
        if (let Some(o) = otherCodeword) {
            if (o.hasValidRowNumber() && o.bucket == codeword.bucket) {
                codeword.rowNumber = o.rowNumber
                return true
            }
        }
        false
    }