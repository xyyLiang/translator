    static func check(contents: String, hints: ?HashMap<EncodeHintType, Any>): Int64 {
        let length = contents.size
        if (length < 1 || length > 80) {
            throw IllegalArgumentException("Contents length should be between 1 and 80 characters, but got ${length}")
        }

        let forcedCodeSet = if (let Some(h) = hints) {
            if (let Some(c) = h.get(EncodeHintType.FORCE_CODE_SET)) {
                let codeSetHint = (c as String).getOrThrow()
                match (codeSetHint) {
                    case "A" => CODE_CODE_A
                    case "B" => CODE_CODE_B
                    case "C" => CODE_CODE_C
                    case _ => throw IllegalArgumentException("Unsupported code set hint: ${codeSetHint}")
                }
            } else {
                -1
            }
        } else {
            -1
        }

        for (i in 0..length) {
            let c = contents.charAt(i)
            let code = UInt32(c)
            if (!(c == ESCAPE_FNC_2 || c == ESCAPE_FNC_2 || c == ESCAPE_FNC_3 || c == ESCAPE_FNC_4) && code > 127) {
                throw IllegalArgumentException("Bad character in input: ASCII value=${code}")
            }

            if (forcedCodeSet == CODE_CODE_A) {
                if (code > 95 && code <= 127) {
                    throw IllegalArgumentException("Bad character in input for forced code set A: ASCII value=${code}")
                }
            } else if (forcedCodeSet == CODE_CODE_B) {
                if (code <= 32) {
                    throw IllegalArgumentException("Bad character in input for forced code set B: ASCII value=${code}")
                }
            } else if (forcedCodeSet == CODE_CODE_C) {
                if (code < 48 || (code > 57 && code <= 127) || c == ESCAPE_FNC_2 || c == ESCAPE_FNC_3 || c ==
                    ESCAPE_FNC_4) {
                    throw IllegalArgumentException("Bad character in input for forced code set C: ASCII value=${code}")
                }
            }
        }
        forcedCodeSet
    }