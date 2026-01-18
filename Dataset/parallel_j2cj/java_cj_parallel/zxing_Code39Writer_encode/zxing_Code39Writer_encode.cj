    public override func encode(oContents: String): Array<Bool> {
        var contents = oContents
        var length = contents.size
        if (length > 80) {
            throw IllegalArgumentException("Requested contents should be less than 80 digits long, but got ${length}")
        }

        for (i in 0..length) {
            let indexInString = Code39Reader.ALPHABET_STRING.indexOf(contents.charAt(i))
            if (let None = indexInString) {
                contents = tryToConvertToExtendedMode(contents)
                length = contents.size
                if (length > 80) {
                    throw IllegalArgumentException(
                        "Requested contents should be less than 80 digits long, but got ${length} (extended full ASCII mode)"
                    )
                }
                break
            }
        }

        let widths: Array<Int64> = Array<Int64>(9, item: 0)
        let codeWidth = 24 + 1 + (13 * length)
        let result: Array<Bool> = Array<Bool>(codeWidth, item: false)
        toIntArray(Code39Reader.ASTERISK_ENCODING, widths)
        var pos = appendPattern(result, 0, widths, true)
        let narrowWhite = [1]
        pos += appendPattern(result, pos, narrowWhite, false)
        for (i in 0..length) {
            let indexInString = Code39Reader.ALPHABET_STRING.indexOf(contents.charAt(i)).getOrThrow()
            toIntArray(Code39Reader.CHARACTER_ENCODINGS[indexInString], widths)
            pos += appendPattern(result, pos, widths, true)
            pos += appendPattern(result, pos, narrowWhite, false)
        }
        toIntArray(Code39Reader.ASTERISK_ENCODING, widths)
        appendPattern(result, pos, widths, true)
        result
    }