    static func encodeASCIIDigits(digit1: Char, digit2: Char): Char {
        if (HighLevelEncoder.isDigit(digit1) && HighLevelEncoder.isDigit(digit2)) {
            let num = (UInt32(digit1) - 48) * 10 + (UInt32(digit2) - 48)
            Char(num + 130)
        } else {
            throw IllegalArgumentException("not digits: ${digit1}${digit2}")
        }
    }