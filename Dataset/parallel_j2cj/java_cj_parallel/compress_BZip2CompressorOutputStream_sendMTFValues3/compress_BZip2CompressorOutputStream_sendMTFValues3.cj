    private func sendMTFValues3(nGroups: Int64, alphaSize: Int64): Unit {
        let code: Array<Array<Int64>> = this.data.sendMTFValues_code
        let len: Array<Array<Byte>> = this.data.sendMTFValues_len

        for (t in 0..nGroups) {
            var minLen: Int64 = 32
            var maxLen: Int64 = 0
            let len_t: Array<Byte> = len[t]
            for (i in alphaSize - 1..=0 : -1) {
                let l: Int64 = Int64(len_t[i])
                if (l > maxLen) {
                    maxLen = l
                }
                if (l < minLen) {
                    minLen = l
                }
            }
            hbAssignCodes(code[t], len[t], minLen, maxLen, alphaSize)
        }
    }
