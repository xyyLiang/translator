    public func charAt(index: Int64): Char {
        if (index < 0 || index >= length()) {
            throw IndexOutOfBoundsException("${index}")
        }
        if (isECI(index)) {
            throw IllegalArgumentException("value at ${index} is not a character but an ECI")
        }
        if (isFNC1(index)) {
            Char(fnc1)
        } else {
            Char(bytes[index])
        }
    }