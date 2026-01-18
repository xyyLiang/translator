    static func randomize255State(ch: Char, codewordPosition: Int64): Char {
        let pseudoRandom = ((149 * codewordPosition) % 255) + 1
        let tempVariable = Int64(UInt32(ch)) + pseudoRandom
        if (tempVariable <= 255) {
            Char(tempVariable)
        } else {
            Char(tempVariable - 256)
        }
    }