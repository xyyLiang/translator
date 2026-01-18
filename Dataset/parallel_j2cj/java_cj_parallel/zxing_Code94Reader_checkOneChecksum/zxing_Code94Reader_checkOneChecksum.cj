    static func checkOneChecksum(result: String, checkPosition: Int64, weightMax: Int64) {
        var weight = 1
        var total = 0
        for (i in (checkPosition - 1)..=0 : -1) {
            total += weight * ALPHABET_STRING.indexOf(result.charAt(i)).getOrThrow()
            weight++
            if (weight > weightMax) {
                weight = 1
            }
        }
        if (result.charAt(checkPosition) != ALPHABET[total % 47]) {
            throw ChecksumException()
        }
    }