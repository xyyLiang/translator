    public override func translate(input: String, index: Int64, writer: Writer): Int64 {
        let seqEnd: Int64 = input.size;

        // Uses -2 to ensure there is something after the &#
        if (input.get(index) == '&' && index < seqEnd - 2 && input.get(index + 1) == '#') {
            var start: Int64 = index + 2
            var isHex: Bool = false;

            let firstChar: Option<Char> = input.get(start);
            if (firstChar == 'x' || firstChar == 'X') {
                start += 1
                isHex = true

                // Check there's more than just an x after the &#
                if (start == seqEnd) {
                    return 0;
                }
            }

            var end: Int64 = start

            // Note that this supports character codes without a ; on the end
            while (end < seqEnd) {
                let endChar: Char = input.get(end) ?? '\0'
                if (!(endChar >= '0' && endChar <= '9' || endChar >= 'a' && endChar <= 'f' || endChar >= 'A' && endChar <=
                    'F')) {
                    break
                }
                end += 1
            }

            let semiNext: Bool = end != seqEnd && input.get(end) == ';'
            if (!semiNext) {
                if (isSet(NumericEntityUnescaperOptions.semiColonRequired)) {
                    return 0;
                }
                if (isSet(NumericEntityUnescaperOptions.errorIfNoSemiColon)) {
                    throw IllegalArgumentException("Semi-colon required at end of numeric entity");
                }
            }

            var numberString: String = input.substring(start, end - start);
            if (isHex) {
                numberString = "0x" + numberString
            }
            let entityValue = Int64.tryParse(numberString);
            if (entityValue == None) {
                return 0;
            }
            writer.write(Char(entityValue ?? 0));

            let hexLength: Int64 = if (isHex) {
                1
            } else {
                0
            }
            let semiNextLength: Int64 = if (semiNext) {
                1
            } else {
                0
            }
            return 2 + end - start + hexLength + semiNextLength
        }
        return 0;
    }