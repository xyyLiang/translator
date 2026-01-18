    public override func encode(oContents: String): Array<Bool> {
        var contents = oContents
        let length = contents.size
        match (length) {
            case 7 =>
                let check = try {
                    UPCEANReader.getStandardUPCEANChecksum(convertUPCEtoUPCA(contents))
                } catch (e: FormatException) {
                    throw IllegalArgumentException(e.toString())
                }
                contents = "${contents}${check}"
            case 8 =>
                try {
                    if (!UPCEANReader.checkStandardUPCEANChecksum(convertUPCEtoUPCA(contents))) {
                        throw IllegalArgumentException("Contents do not pass checksum")
                    }
                } catch (_: FormatException) {
                    throw IllegalArgumentException("Illegal contents")
                }
            case _ =>
                throw IllegalArgumentException("Requested contents should be 7 or 8 digits long, but got ${length}")
        }

        checkNumeric(contents)

        let firstDigit = charDigit(contents.charAt(0), 10)
        if (firstDigit != 0 && firstDigit != 1) {
            throw IllegalArgumentException("Number system must be 0 or 1")
        }

        let checkDigit = charDigit(contents.charAt(7), 10)
        let parities = UPCEReader.NUMSYS_AND_CHECK_DIGIT_PATTERNS[firstDigit][checkDigit]
        let result = Array<Bool>(CODE_WIDTH, item: false)

        var pos = appendPattern(result, 0, UPCEANReader.START_END_PATTERN, true)

        for (i in 1..7) {
            var digit = charDigit(contents.charAt(i), 10)
            if ((parities >> (6 - i) & 1) == 1) {
                digit += 10
            }
            pos += appendPattern(result, pos, UPCEANReader.L_AND_G_PATTERNS[digit], false)
        }

        appendPattern(result, pos, UPCEANReader.END_PATTERN, false)

        result
    }