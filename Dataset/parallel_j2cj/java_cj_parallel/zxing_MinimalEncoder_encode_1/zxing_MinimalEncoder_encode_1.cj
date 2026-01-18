    func encode(contents: String, charset: MinimalEncoderCharset, position: Int64): Int64 {
        if (position >= contents.size) {
            throw Exception()
        }
        let mCost = memoizedCost[charset.code()][position]
        if (mCost > 0) {
            return mCost
        }

        var minCost = Int64.Max
        var minLatch = MinimalEncoderLatch.NONE
        var atEnd = position + 1 >= contents.size

        let sets = [MinimalEncoderCharset.A, MinimalEncoderCharset.B]
        for (i in 0..2) {
            if (canEncode(contents, sets[i], position)) {
                var cost = 1
                var latch = MinimalEncoderLatch.NONE
                if (charset != sets[i]) {
                    cost++
                    latch = MinimalEncoderLatch.valueOf(sets[i].toString())
                }
                if (!atEnd) {
                    cost += encode(contents, sets[i], position + 1)
                }
                if (cost < minCost) {
                    minCost = cost
                    minLatch = latch
                }
                cost = 1
                if (charset == sets[(i + 1) % 2]) {
                    cost++
                    latch = MinimalEncoderLatch.SHIFT
                    if (!atEnd) {
                        cost += encode(contents, charset, position + 1)
                    }
                    if (cost < minCost) {
                        minCost = cost
                        minLatch = latch
                    }
                }
            }
        }
        if (canEncode(contents, MinimalEncoderCharset.C, position)) {
            var cost = 1
            var latch = MinimalEncoderLatch.NONE
            if (charset != MinimalEncoderCharset.C) {
                cost++
                latch = MinimalEncoderLatch.C
            }
            let advance = if (contents.charAt(position) == Code128Writer.ESCAPE_FNC_1) {
                1
            } else {
                2
            }
            if (position + advance < contents.size) {
                cost += encode(contents, MinimalEncoderCharset.C, position + advance)
            }
            if (cost < minCost) {
                minCost = cost
                minLatch = latch
            }
        }
        if (minCost == Int64.Max) {
            throw IllegalArgumentException("Bad character in input: ASCII value=${contents.charAt(position)}")
        }
        memoizedCost[charset.code()][position] = minCost
        minPath[charset.code()][position] = minLatch
        minCost
    }