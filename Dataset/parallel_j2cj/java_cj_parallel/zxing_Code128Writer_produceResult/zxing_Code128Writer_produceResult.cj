    static func produceResult(patterns: ArrayList<Array<Int64>>, oCheckSum: Int64): Array<Bool> {
        let checkSum = oCheckSum % 103
        patterns.append(Code128Reader.CODE_PATTERNS[checkSum])

        patterns.append(Code128Reader.CODE_PATTERNS[CODE_STOP])

        var codeWidth = 0
        for (pattern in patterns) {
            for (width in pattern) {
                codeWidth += width
            }
        }

        let result = Array<Bool>(codeWidth, item: false)
        var pos = 0
        for (pattern in patterns) {
            pos += appendPattern(result, pos, pattern, true)
        }

        result
    }