    static func findCType(value: String, start: Int64): CType {
        let last = value.size
        if (start >= last) {
            return CType.UNCODABLE
        }
        var c = value.charAt(start)
        if (c == ESCAPE_FNC_1) {
            return CType.FNC_1
        }
        if (c < '0' || c > '9') {
            return CType.UNCODABLE
        }
        if (start + 1 >= last) {
            return CType.ONE_DIGIT
        }
        c = value.charAt(start + 1)
        if (c < '0' || c > '9') {
            return CType.ONE_DIGIT
        }
        CType.TWO_DIGITS
    }