    private func createHuffmanDecodingTables(alphaSize: Int64, nGroups: Int64): Unit {
        let dataShadow: BZip2InputStreamData = this.data()
        let len: Array<Array<UInt8>> = dataShadow.temp_charArray2d
        let minLens: Array<Int64> = dataShadow.minLens
        let limit: Array<Array<Int64>> = dataShadow.limit
        let base: Array<Array<Int64>> = dataShadow.base
        let perm: Array<Array<Int64>> = dataShadow.perm

        for (t in 0..nGroups) {
            var minLen: UInt8 = 32
            var maxLen: UInt8 = 0
            let len_t: Array<UInt8> = len[t]
            for (i in alphaSize - 1..=0 : -1) {
                let lent: UInt8 = len_t[i]
                if (lent > maxLen) {
                    maxLen = lent
                }
                if (lent < minLen) {
                    minLen = lent
                }
            }
            hbCreateDecodeTables(limit[t], base[t], perm[t], len[t], Int64(minLen), Int64(maxLen), alphaSize)
            minLens[t] = Int64(minLen)
        }
    }