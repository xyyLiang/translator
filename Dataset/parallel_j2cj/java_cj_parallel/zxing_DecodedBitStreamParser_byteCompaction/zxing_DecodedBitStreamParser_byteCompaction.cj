    static func byteCompaction(mode: Int64, codewords: Array<Int64>, ocodeIndex: Int64, result: StringBuilder): Int64 {
        var codeIndex = ocodeIndex
        var end = false
        while (codeIndex < codewords[0] && !end) {
            while (codeIndex < codewords[0] && codewords[codeIndex] == ECI_CHARSET) {
                codeIndex += 2
            }

            if (codeIndex >= codewords[0] || codewords[codeIndex] >= TEXT_COMPACTION_MODE_LATCH) {
                end = true
            } else {
                var value = 0
                var count = 0
                do {
                    value = 900 * value + codewords[codeIndex]
                    codeIndex++
                    count++
                } while (count < 5 && codeIndex < codewords[0] && codewords[codeIndex] < TEXT_COMPACTION_MODE_LATCH)
                if (count == 5 && (mode == BYTE_COMPACTION_MODE_LATCH_6 || codeIndex < codewords[0] &&
                    codewords[codeIndex] < TEXT_COMPACTION_MODE_LATCH)) {
                    for (i in 0..6) {
                        result.append(UInt8(value >> (8 * (5 - i))))
                    }
                } else {
                    codeIndex -= count
                    while ((codeIndex < codewords[0]) && !end) {
                        let code = codewords[codeIndex]
                        codeIndex++
                        if (code < TEXT_COMPACTION_MODE_LATCH) {
                            result.append(UInt8(code))
                        } else if (code == ECI_CHARSET) {
                            codeIndex++
                        } else {
                            codeIndex--
                            end = true
                        }
                    }
                }
            }
        }
        codeIndex
    }