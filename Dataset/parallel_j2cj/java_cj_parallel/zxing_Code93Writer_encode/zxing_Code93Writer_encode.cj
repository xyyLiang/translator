    public func encode(oContents: String): Array<Bool> {
        var contents = convertToExtended(oContents)
        let length = contents.size
        if (length > 80) {
            throw IllegalArgumentException(
                "Requested contents should be less than 80 digits long after converting to extended encoding, but got ${length}"
            )
        }

        let codeWidth = (length + 2 + 2) * 9 + 1

        let result = Array<Bool>(codeWidth, item: false)

        var pos = appendPattern(result, 0, Code93Reader.ASTERISK_ENCODING)

        for (i in 0..length) {
            let indexInString = Code93Reader.ALPHABET_STRING.indexOf(contents.charAt(i)).getOrThrow()
            pos += appendPattern(result, pos, Code93Reader.CHARACTER_ENCODINGS[indexInString])
        }

        let check1 = computeChecksumIndex(contents, 20)
        pos += appendPattern(result, pos, Code93Reader.CHARACTER_ENCODINGS[check1])

        contents += Code93Reader.ALPHABET_STRING.charAt(check1)

        let check2 = computeChecksumIndex(contents, 15)
        pos += appendPattern(result, pos, Code93Reader.CHARACTER_ENCODINGS[check2])

        pos += appendPattern(result, pos, Code93Reader.ASTERISK_ENCODING)

        result[pos] = true

        result
    }