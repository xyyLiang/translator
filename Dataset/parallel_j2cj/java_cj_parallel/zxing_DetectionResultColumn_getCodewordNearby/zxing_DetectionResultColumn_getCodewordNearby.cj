    func getCodewordNearby(imageRow: Int64): ?Codeword {
        if (let Some(codeword) = getCodeword(imageRow)) {
            return codeword
        }
        for (i in 1..MAX_NEARBY_DISTANCE) {
            var nearImageRow = imageRowToCodewordIndex(imageRow) - i
            if (nearImageRow >= 0) {
                if (let Some(codeword) = codewords[nearImageRow]) {
                    return codeword
                }
            }
            nearImageRow = imageRowToCodewordIndex(imageRow) + i
            if (nearImageRow < codewords.size) {
                if (let Some(codeword) = codewords[nearImageRow]) {
                    return codeword
                }
            }
        }
        None
    }