    public override func encode(oContents: String): Array<Bool> {
        var contents = if (oContents.size < 2) {
            "${DEFAULT_GUARD}${oContents}${DEFAULT_GUARD}"
        } else {
            let firstChar = oContents.charAt(0).toUpperCase()
            let lastChar = oContents.charAt(oContents.size - 1).toUpperCase()
            let startsNormal = CodaBarReader.arrayContains(START_END_CHARS, firstChar)
            let endsNormal = CodaBarReader.arrayContains(START_END_CHARS, lastChar)
            let startsAlt = CodaBarReader.arrayContains(ALT_START_END_CHARS, firstChar)
            let endsAlt = CodaBarReader.arrayContains(ALT_START_END_CHARS, lastChar)
            if (startsNormal) {
                if (!endsNormal) {
                    throw IllegalArgumentException("Invalid start/end guards: ${oContents}")
                }
                oContents
            } else if (startsAlt) {
                if (!endsAlt) {
                    throw IllegalArgumentException("Invalid start/end guards: ${oContents}")
                }
                oContents
            } else {
                if (endsNormal || endsAlt) {
                    throw IllegalArgumentException("Invalid start/end guards: ${oContents}")
                }
                "${DEFAULT_GUARD}${oContents}${DEFAULT_GUARD}"
            }
        }

        var resultLength = 20
        for (i in 1..(contents.size - 1)) {
            if (contents.charAt(i).isNumber() || contents.charAt(i) == '-' || contents.charAt(i) == '$') {
                resultLength += 9
            } else if (CodaBarReader.arrayContains(CHARS_WHICH_ARE_TEN_LENGTH_EACH_AFTER_DECODED, contents.charAt(i))) {
                resultLength += 10
            } else {
                throw IllegalArgumentException("Cannot encode : '${contents.charAt(i)}'")
            }
        }
        resultLength += contents.size - 1

        let result = Array<Bool>(resultLength, item: false)
        var position = 0
        for (index in 0..contents.size) {
            var c = contents.charAt(index).toUpperCase()
            if (index == 0 || index == contents.size - 1) {
                c = match (c) {
                    case 'T' => 'A'
                    case 'N' => 'B'
                    case '*' => 'C'
                    case 'E' => 'D'
                    case _ => c
                }
            }
            var code = 0
            for (i in 0..CodaBarReader.ALPHABET.size) {
                if (c == CodaBarReader.ALPHABET[i]) {
                    code = CodaBarReader.CHARACTER_ENCODINGS[i]
                    break
                }
            }
            var color = true
            var counter = 0
            var bit = 0
            while (bit < 7) {
                result[position] = color
                position++
                if (((code >> (6 - bit)) & 1) == 0 || counter == 1) {
                    color = !color
                    bit++
                    counter = 0
                } else {
                    counter++
                }
            }
            if (index < contents.size - 1) {
                result[position] = false
                position++
            }
        }
        result
    }