    static func decodeBase900toBase10(codewords: Array<Int64>, count: Int64): String {
        var result = 0
        for (i in 0..count) {
            result += EXP900[count - i - 1] * codewords[i]
        }
        let resultString = "${result}"
        if (resultString.charAt(0) != '1') {
            throw FormatException()
        }
        resultString[1..resultString.size]
    }