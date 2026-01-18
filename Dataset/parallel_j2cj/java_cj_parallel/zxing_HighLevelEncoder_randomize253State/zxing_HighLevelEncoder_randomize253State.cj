    static func randomize253State(codewordPosition: Int64): Char {
        let pseudoRandom = UInt32(((149 * codewordPosition) % 253) + 1)
        let tempVariable = UInt32(PAD) + pseudoRandom
        Char(if (tempVariable <= 254) {
                tempVariable
            } else {
                tempVariable - 254
            })
    }