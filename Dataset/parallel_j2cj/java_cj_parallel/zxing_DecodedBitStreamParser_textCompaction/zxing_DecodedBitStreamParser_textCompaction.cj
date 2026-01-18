    static func textCompaction(codewords: Array<Int64>, ocodeIndex: Int64, result: StringBuilder): Int64 {
        var codeIndex = ocodeIndex
        var size = (codewords[0] - codeIndex) * 2
        var textCompactionData = Array<Int64>(size, item: 0)
        var byteCompactionData = Array<Int64>(size, item: 0)
        var index = 0
        var end = false
        var subMode = ALPHA
        while ((codeIndex < codewords[0]) && !end) {
            var code = codewords[codeIndex]
            codeIndex++
            if (code < TEXT_COMPACTION_MODE_LATCH) {
                textCompactionData[index] = code / 30
                textCompactionData[index + 1] = code % 30
                index += 2
            } else {
                if (code == TEXT_COMPACTION_MODE_LATCH) {
                    textCompactionData[index] = TEXT_COMPACTION_MODE_LATCH
                    index++
                } else if (code == BYTE_COMPACTION_MODE_LATCH || code == BYTE_COMPACTION_MODE_LATCH_6 || code ==
                    NUMERIC_COMPACTION_MODE_LATCH || code == BEGIN_MACRO_PDF417_CONTROL_BLOCK || code ==
                    BEGIN_MACRO_PDF417_OPTIONAL_FIELD || code == MACRO_PDF417_TERMINATOR) {
                    codeIndex--
                    end = true
                } else if (code == MODE_SHIFT_TO_BYTE_COMPACTION_MODE) {
                    textCompactionData[index] = MODE_SHIFT_TO_BYTE_COMPACTION_MODE
                    code = codewords[codeIndex]
                    codeIndex++
                    byteCompactionData[index] = code
                    index++
                } else if (code == ECI_CHARSET) {
                    subMode = decodeTextCompaction(textCompactionData, byteCompactionData, index, result, subMode)
                    codeIndex++
                    if (codeIndex > codewords[0]) {
                        throw FormatException()
                    }
                    size = (codewords[0] - codeIndex) * 2
                    textCompactionData = Array<Int64>(size, item: 0)
                    byteCompactionData = Array<Int64>(size, item: 0)
                    index = 0
                }
            }
        }
        decodeTextCompaction(textCompactionData, byteCompactionData, index, result, subMode)
        codeIndex
    }