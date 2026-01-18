    static func decode(codewords: Array<Int64>, ecLevel: String): DecoderResult {
        let result = StringBuilder()
        var codeIndex = textCompaction(codewords, 1, result)
        let resultMetadata = PDF417ResultMetadata()
        while (codeIndex < codewords[0]) {
            let code = codewords[codeIndex]
            codeIndex++
            if (code == TEXT_COMPACTION_MODE_LATCH) {
                codeIndex = textCompaction(codewords, codeIndex, result)
            } else if (code == BYTE_COMPACTION_MODE_LATCH || code == BYTE_COMPACTION_MODE_LATCH_6) {
                codeIndex = byteCompaction(
                    code,
                    codewords,
                    codeIndex,
                    result
                )
            } else if (code == MODE_SHIFT_TO_BYTE_COMPACTION_MODE) {
                result.append(Char(codewords[codeIndex]))
                codeIndex++
            } else if (code == NUMERIC_COMPACTION_MODE_LATCH) {
                codeIndex = numericCompaction(codewords, codeIndex, result)
            } else if (code == ECI_CHARSET) {
                codeIndex++
            } else if (code == ECI_GENERAL_PURPOSE) {
                codeIndex += 2
            } else if (code == ECI_USER_DEFINED) {
                codeIndex++
            } else if (code == BEGIN_MACRO_PDF417_CONTROL_BLOCK) {
                codeIndex = decodeMacroBlock(
                    codewords,
                    codeIndex,
                    resultMetadata
                )
            } else if (code == BEGIN_MACRO_PDF417_OPTIONAL_FIELD || code == MACRO_PDF417_TERMINATOR) {
                throw FormatException()
            } else {
                codeIndex--
                codeIndex = textCompaction(codewords, codeIndex, result)
            }
        }
        if (result.isEmpty()) {
            if (let None = resultMetadata.fileId) {
                throw FormatException()
            }
        }
        let decoderResult = DecoderResult(None, result.toString(), None, ecLevel)
        decoderResult.other = resultMetadata
        decoderResult
    }