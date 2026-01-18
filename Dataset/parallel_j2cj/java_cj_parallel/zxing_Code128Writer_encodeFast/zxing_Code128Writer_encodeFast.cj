    static func encodeFast(contents: String, forcedCodeSet: Int64): Array<Bool> {
        let length = contents.size

        let patterns = ArrayList<Array<Int64>>()

        var checkSum = 0
        var checkWeight = 1
        var codeSet = 0
        var position = 0

        while (position < length) {
            let newCodeSet = if (forcedCodeSet == -1) {
                chooseCode(contents, position, codeSet)
            } else {
                forcedCodeSet
            }

            var patternIndex = 0
            if (newCodeSet == codeSet) {
                let c = contents.charAt(position)
                patternIndex = if (c == ESCAPE_FNC_1) {
                    CODE_FNC_1
                } else if (c == ESCAPE_FNC_2) {
                    CODE_FNC_2
                } else if (c == ESCAPE_FNC_3) {
                    CODE_FNC_3
                } else if (c == ESCAPE_FNC_4) {
                    if (codeSet == CODE_CODE_A) {
                        CODE_FNC_4_A
                    } else {
                        CODE_FNC_4_B
                    }
                } else {
                    if (codeSet == CODE_CODE_A) {
                        var p = Int64(UInt32(contents.charAt(position))) - Int64(UInt32(' '))
                        if (p < 0) {
                            p += Int64(UInt32('`'))
                        }
                        p
                    }
                    if (codeSet == CODE_CODE_B) {
                        Int64(UInt32(contents.charAt(position))) - Int64(UInt32(' '))
                    } else {
                        if (position + 1 == length) {
                            throw IllegalArgumentException("Bad number of characters for digit only encoding.")
                        }
                        let p = Int64.parse(contents[position..(position + 2)])
                        position++
                        p
                    }
                }
                position++
            } else {
                patternIndex = if (codeSet == 0) {
                    if (newCodeSet == CODE_CODE_A) {
                        CODE_START_A
                    } else if (newCodeSet == CODE_CODE_B) {
                        CODE_START_B
                    } else {
                        CODE_START_C
                    }
                } else {
                    newCodeSet
                }
                codeSet = newCodeSet
            }

            patterns.append(Code128Reader.CODE_PATTERNS[patternIndex])

            checkSum += patternIndex * checkWeight
            if (position != 0) {
                checkWeight++
            }
        }
        produceResult(patterns, checkSum)
    }