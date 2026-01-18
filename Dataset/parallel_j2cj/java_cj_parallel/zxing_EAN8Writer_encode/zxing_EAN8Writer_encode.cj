    public func encode(oContents: String): Array<Bool> {
        var contents = oContents
        let length = contents.size
        match (length) {
            case 7 =>
                let check = try {
                    UPCEANReader.getStandardUPCEANChecksum(contents)
                } catch (e: FormatException) {
                    throw IllegalArgumentException(e.toString())
                }
                contents = "${contents}${check}"
            case 8 =>
                try {
                    if (!UPCEANReader.checkStandardUPCEANChecksum(contents)) {
                        throw IllegalArgumentException("Contents do not pass checksum")
                    }
                } catch (_: FormatException) {
                    throw IllegalArgumentException("Illegal contents")
                }
            case _ =>
                throw IllegalArgumentException("Requested contents should be 7 or 8 digits long, but got ${length}")
        }

        checkNumeric(contents)

        let result = Array<Bool>(CODE_WIDTH, item: false)
        var pos = appendPattern(result, 0, UPCEANReader.START_END_PATTERN, true)

        for (i in 0..4) {
            let digit = charDigit(contents.charAt(i), 10)
            pos += appendPattern(result, pos, UPCEANReader.L_PATTERNS[digit], false)
        }

        pos += appendPattern(result, pos, UPCEANReader.MIDDLE_PATTERN, false)

        for (i in 4..8) {
            let digit = charDigit(contents.charAt(i), 10)
            pos += appendPattern(result, pos, UPCEANReader.L_PATTERNS[digit], true)
        }
        appendPattern(result, pos, UPCEANReader.START_END_PATTERN, true)

        return result
    }
