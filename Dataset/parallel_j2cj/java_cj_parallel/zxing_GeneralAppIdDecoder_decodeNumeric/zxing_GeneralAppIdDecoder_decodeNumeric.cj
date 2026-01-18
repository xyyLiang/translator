    func decodeNumeric(pos: Int64): DecodedNumeric {
        if (pos + 7 > this.information.size) {
            let numeric = extractNumericValueFromBitArray(pos, 4)
            if (numeric == 0) {
                return DecodedNumeric(this.information.size, DecodedNumeric.FNC1, DecodedNumeric.FNC1)
            }
            return DecodedNumeric(this.information.size, numeric - 1, DecodedNumeric.FNC1)
        }
        let numeric = extractNumericValueFromBitArray(pos, 7)

        let digit1 = (numeric - 8) / 11
        let digit2 = (numeric - 8) % 11

        DecodedNumeric(pos + 7, digit1, digit2)
    }