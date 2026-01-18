    func encode(contents: String): Array<Bool> {
        let length = contents.size
        memoizedCost = Array<Array<Int64>>(4, {n => Array<Int64>(length, item: 0)})
        minPath = Array<Array<MinimalEncoderLatch>>(
            4,
            {n => Array<MinimalEncoderLatch>(length, item: MinimalEncoderLatch.A)}
        )

        encode(contents, MinimalEncoderCharset.NONE, 0)

        let patterns = ArrayList<Array<Int64>>()
        let checkSum = [0]
        let checkWeight = [1]
        var charset = MinimalEncoderCharset.NONE
        var i = 0
        while (i < length) {
            let latch = minPath[charset.code()][i]
            match (latch) {
                case A =>
                    charset = MinimalEncoderCharset.A
                    addPattern(
                        patterns,
                        if (i == 0) {
                            Code128Writer.CODE_START_A
                        } else {
                            Code128Writer.CODE_CODE_A
                        },
                        checkSum,
                        checkWeight,
                        i
                    )
                case B =>
                    charset = MinimalEncoderCharset.B
                    addPattern(
                        patterns,
                        if (i == 0) {
                            Code128Writer.CODE_START_B
                        } else {
                            Code128Writer.CODE_CODE_B
                        },
                        checkSum,
                        checkWeight,
                        i
                    )
                case C =>
                    charset = MinimalEncoderCharset.C
                    addPattern(
                        patterns,
                        if (i == 0) {
                            Code128Writer.CODE_START_C
                        } else {
                            Code128Writer.CODE_CODE_C
                        },
                        checkSum,
                        checkWeight,
                        i
                    )
                case SHIFT => addPattern(patterns, CODE_SHIFT, checkSum, checkWeight, i)
                case _ => ()
            }
            if (charset == MinimalEncoderCharset.C) {
                if (contents.charAt(i) == Code128Writer.ESCAPE_FNC_1) {
                    addPattern(patterns, Code128Writer.CODE_FNC_1, checkSum, checkWeight, i)
                } else {
                    addPattern(patterns, Int64.parse(contents[i..(i + 2)]), checkSum, checkWeight, i)
                    if (i + 1 >= length) {
                        throw Exception()
                    }
                    if (i + 1 < length) {
                        i++
                    }
                }
            } else {
                let c = contents.charAt(i)
                var patternIndex: Int64 = if (c == Code128Writer.ESCAPE_FNC_1) {
                    Code128Writer.CODE_FNC_1
                } else if (c == Code128Writer.ESCAPE_FNC_2) {
                    Code128Writer.CODE_FNC_2
                } else if (c == Code128Writer.ESCAPE_FNC_3) {
                    Code128Writer.CODE_FNC_3
                } else if (c == Code128Writer.ESCAPE_FNC_4) {
                    if (charset == MinimalEncoderCharset.A && latch != MinimalEncoderLatch.SHIFT ||
                        charset == MinimalEncoderCharset.B && latch == MinimalEncoderLatch.SHIFT) {
                        Code128Writer.CODE_FNC_4_A
                    } else {
                        Code128Writer.CODE_FNC_4_B
                    }
                } else {
                    Int64(UInt32(contents.charAt(i)) - UInt32(' '))
                }

                if ((charset == MinimalEncoderCharset.A && latch != MinimalEncoderLatch.SHIFT ||
                    charset == MinimalEncoderCharset.B && latch == MinimalEncoderLatch.SHIFT) && patternIndex < 0) {
                    patternIndex += Int64(UInt32('`'))
                }
                addPattern(patterns, patternIndex, checkSum, checkWeight, i)
            }
            i++
        }
        Code128Writer.produceResult(patterns, checkSum[0])
    }