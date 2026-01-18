    static func computeChecksumIndex(contents: String, maxWeight: Int64): Int64 {
        var weight = 1
        var total = 0

        for (i in (contents.size - 1)..=0 : -1) {
            let indexInString = Code93Reader.ALPHABET_STRING.indexOf(contents.charAt(i)).getOrThrow()
            total += indexInString * weight
            weight++
            if (weight > maxWeight) {
                weight = 1
            }
        }
        total % 47
    }