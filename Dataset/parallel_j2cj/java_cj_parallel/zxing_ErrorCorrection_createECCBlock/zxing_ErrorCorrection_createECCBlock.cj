    static func createECCBlock(codewords: String, numECWords: Int64): String {
        var table = -1;
        for (i in 0..FACTOR_SETS.size) {
            if (FACTOR_SETS[i] == numECWords) {
                table = i
                break
            }
        }
        if (table < 0) {
            throw IllegalArgumentException("Illegal number of error correction codewords specified: ${numECWords}");
        }

        let poly = FACTORS[table]
        let ecc = Array<Char>(numECWords, {n => Char(0)})
        for (i in 0..codewords.size) {
            let m = Int64(UInt32(ecc[numECWords - 1]) ^ UInt32(codewords.charAt(i)))
            for (k in (numECWords - 1)..0 : -1) {
                if (m != 0 && poly[k] != 0) {
                    ecc[k] = Char(Int64(UInt32(ecc[k - 1])) ^ ALOG[(LOG[m] + LOG[poly[k]]) % 255])
                } else {
                    ecc[k] = ecc[k - 1]
                }
            }
            if (m != 0 && poly[0] != 0) {
                ecc[0] = Char(ALOG[(LOG[m] + LOG[poly[0]]) % 255])
            } else {
                ecc[0] = Char(0)
            }
        }
        let eccReversed = Array<Char>(numECWords, {
                i => ecc[numECWords - i - 1]
            })
        eccReversed.toString()
    }
