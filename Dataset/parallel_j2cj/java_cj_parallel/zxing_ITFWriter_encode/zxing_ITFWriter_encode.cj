    public override func encode(contents: String): Array<Bool> {
        let length = contents.size
        if (length % 2 != 0) {
            throw IllegalArgumentException("The length of the input should be even")
        }
        if (length > 80) {
            throw IllegalArgumentException("Requested contents should be less than 80 digits long, but got ${length}")
        }

        checkNumeric(contents)

        let result = Array<Bool>(9 + 9 * length, item: false)
        var pos = appendPattern(result, 0, START_PATTERN, true)
        for (i in 0..length : 2) {
            let one = charDigit(contents.charAt(i), 10)
            let two = charDigit(contents.charAt(i + 1), 10)
            let encoding = Array<Int64>(10, item: 0)
            for (j in 0..5) {
                encoding[2 * j] = PATTERNS[one][j]
                encoding[2 * j + 1] = PATTERNS[two][j]
            }
            pos += appendPattern(result, pos, encoding, true)
        }
        appendPattern(result, pos, END_PATTERN, true)

        result
    }
