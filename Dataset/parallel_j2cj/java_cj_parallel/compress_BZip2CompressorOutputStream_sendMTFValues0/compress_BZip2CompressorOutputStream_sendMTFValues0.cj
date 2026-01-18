    private func sendMTFValues0(nGroups: Int64, alphaSize: Int64) {
        let len: Array<Array<Byte>> = this.data.sendMTFValues_len
        let mtfFreq: Array<Int64> = this.data.mtfFreq

        var remF: Int64 = this.nMTF
        var gs: Int64 = 0

        for (nPart in nGroups..0 : -1) {
            let tFreq: Int64 = remF / nPart
            var ge: Int64 = gs - 1
            var aFreq: Int64 = 0

            let a: Int64 = alphaSize - 1
            while ((aFreq < tFreq) && (ge < a)) {
                ge++
                aFreq += mtfFreq[ge]
            }

            if ((ge > gs) && (nPart != nGroups) && (nPart != 1) && (((nGroups - nPart) & 1) != 0)) {
                aFreq -= mtfFreq[ge]
                ge--
            }

            let len_np: Array<Byte> = len[nPart - 1]
            for (v in alphaSize - 1..=0 : -1) {
                if ((v >= gs) && (v <= ge)) {
                    len_np[v] = LESSER_ICOST
                } else {
                    len_np[v] = GREATER_ICOST
                }
            }
            gs = ge + 1
            remF -= aFreq
        }
    }