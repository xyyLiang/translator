    static func chooseCode(value: String, start: Int64, oldCode: Int64): Int64 {
        var lookahead = findCType(value, start)
        if (lookahead == CType.ONE_DIGIT) {
            if (oldCode == CODE_CODE_A) {
                return CODE_CODE_A
            }
            return CODE_CODE_B
        }
        if (lookahead == CType.UNCODABLE) {
            if (start < value.size) {
                let c = value.charAt(start)
                if (c < ' ' || (oldCode == CODE_CODE_A && (c < '`' || (c >= ESCAPE_FNC_1 && c <= ESCAPE_FNC_4)))) {
                    return CODE_CODE_A
                }
            }
            return CODE_CODE_B
        }
        if (oldCode == CODE_CODE_A && lookahead == CType.FNC_1) {
            return CODE_CODE_A
        }
        if (oldCode == CODE_CODE_C) {
            return CODE_CODE_C
        }
        if (oldCode == CODE_CODE_B) {
            if (lookahead == CType.FNC_1) {
                return CODE_CODE_B
            }
            lookahead = findCType(value, start + 2)
            if (lookahead == CType.UNCODABLE || lookahead == CType.ONE_DIGIT) {
                return CODE_CODE_B
            }
            if (lookahead == CType.FNC_1) {
                lookahead = findCType(value, start + 3)
                if (lookahead == CType.TWO_DIGITS) {
                    return CODE_CODE_C
                } else {
                    return CODE_CODE_B
                }
            }
            var index = start + 4
            func find(): CType {
                lookahead = findCType(value, index)
                lookahead
            }
            while (find() == CType.TWO_DIGITS) {
                index += 2
            }
            if (lookahead == CType.ONE_DIGIT) {
                return CODE_CODE_B
            }
            return CODE_CODE_C
        }
        if (lookahead == CType.FNC_1) {
            lookahead = findCType(value, start + 1)
        }
        if (lookahead == CType.TWO_DIGITS) {
            return CODE_CODE_C
        }
        CODE_CODE_B
    }