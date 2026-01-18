    static func appendLengthInfo(numLetters: Int64, version: Version, mode: Mode, bits: BitArray) {
        let numBits = mode.getCharacterCountBits(version)
        if (numLetters >= (1 << numBits)) {
            throw WriterException("${numLetters} is bigger than ${((1 << numBits) - 1)}")
        }
        bits.appendBits(numLetters, numBits)
    }