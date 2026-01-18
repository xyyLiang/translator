    private static func hbCreateDecodeTables(
        limit: Array<Int64>,
        base: Array<Int64>,
        perm: Array<Int64>,
        length: Array<UInt8>,
        minLen: Int64,
        maxLen: Int64,
        alphaSize: Int64
    ): Unit {
        var pp = 0
        for (i in minLen..=maxLen) {
            for (j in 0..alphaSize) {
                if (i == length[j]) {
                    perm[pp] = j
                    pp += 1
                }
            }
        }

        for (i in MAX_CODE_LEN - 1..0 : -1) {
            base[i] = 0
            limit[i] = 0
        }

        for (i in 0..alphaSize) {
            let l: Int64 = Int64(length[i])
            checkBounds(l, MAX_ALPHA_SIZE, "length")
            base[l + 1] += 1
        }

        var b1 = base[0]
        for (i in 1..MAX_CODE_LEN) {
            b1 += base[i]
            base[i] = b1
        }

        var (vec, b2) = (0, base[minLen])
        for (i in minLen..=maxLen) {
            let nb: Int64 = base[i + 1]
            vec += nb - b2
            b2 = nb
            limit[i] = vec - 1
            vec <<= 1
        }

        for (i in minLen + 1..=maxLen) {
            base[i] = ((limit[i - 1] + 1) << 1) - base[i]
        }
    }