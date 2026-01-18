    static func numericCompaction(codewords: Array<Int64>, ocodeIndex: Int64, result: StringBuilder): Int64 {
        var codeIndex = ocodeIndex
        var count = 0
        var end = false
        let numericCodewords = Array<Int64>(MAX_NUMERIC_CODEWORDS, item: 0)
        while (codeIndex < codewords[0] && !end) {
            let code = codewords[codeIndex]
            codeIndex++
            if (codeIndex == codewords[0]) {
                end = true
            }
            if (code < TEXT_COMPACTION_MODE_LATCH) {
                numericCodewords[count] = code
                count++
            } else if (code == TEXT_COMPACTION_MODE_LATCH || code == BYTE_COMPACTION_MODE_LATCH || code ==
                BYTE_COMPACTION_MODE_LATCH_6 || code == BEGIN_MACRO_PDF417_CONTROL_BLOCK || code ==
                BEGIN_MACRO_PDF417_OPTIONAL_FIELD || code == MACRO_PDF417_TERMINATOR || code == ECI_CHARSET) {
                codeIndex--
                end = true
            }
            if ((count % MAX_NUMERIC_CODEWORDS == 0 || code == NUMERIC_COMPACTION_MODE_LATCH || end) && count > 0) {
                result.append(decodeBase900toBase10(numericCodewords, count))
                count = 0
            }
        }
        codeIndex
    }