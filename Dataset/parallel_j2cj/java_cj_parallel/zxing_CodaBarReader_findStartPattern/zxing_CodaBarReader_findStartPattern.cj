    func findStartPattern(): Int64 {
        for (i in 1..counterLength : 2) {
            let charOffset = toNarrowWidePattern(i)
            if (charOffset != -1 && arrayContains(STARTEND_ENCODING, ALPHABET[charOffset])) {
                var patternSize = 0
                for (j in i..(i + 7)) {
                    patternSize += counters[j]
                }
                if (i == 1 || counters[i - 1] >= patternSize / 2) {
                    return i
                }
            }
        }
        throw NotFoundException()
    }