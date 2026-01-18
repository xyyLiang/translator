    public func encode(oContents: String): Array<Bool> {
        var contents = oContents
        let length = contents.size
        match (length) {
            case 12 =>
                let check = try {
                    UPCEANReader.getStandardUPCEANChecksum(contents)
                } catch (e: FormatException) {
                    throw IllegalArgumentException(e.toString())
                }
                contents = "${contents}${check}"
            case 13 =>
                try {
                    if (!UPCEANReader.checkStandardUPCEANChecksum(contents)) {
                        throw IllegalArgumentException("Contents do not pass checksum")
                    }
                } catch (_: FormatException) {
                    throw IllegalArgumentException("Illegal contents")
                }
            case _ =>
                throw IllegalArgumentException("Requested contents should be 12 or 13 digits long, but got ${length}")
        }

        checkNumeric(contents)

        let firstDigit = charDigit(contents.charAt(0), 10)
        let parities = EAN13Reader.FIRST_DIGIT_ENCODINGS[firstDigit]
        let result = Array<Bool>(CODE_WIDTH, item: false)
        var pos = appendPattern(result, 0, UPCEANReader.START_END_PATTERN, true)

        for (i in 1..7) {
            var digit = charDigit(contents.charAt(i), 10)
            if ((parities >> (6 - i) & 1) == 1) {
                digit += 10
            }
            pos += appendPattern(result, pos, UPCEANReader.L_AND_G_PATTERNS[digit], false)
        }

        pos += appendPattern(result, pos, UPCEANReader.MIDDLE_PATTERN, false)

        for (i in 7..13) {
            let digit = charDigit(contents.charAt(i), 10)
            pos += appendPattern(result, pos, UPCEANReader.L_PATTERNS[digit], true)
        }
        appendPattern(result, pos, UPCEANReader.START_END_PATTERN, true)

        result
    }