    private func sendMTFValues2(nGroups: Int64, nSelectors: Int64): Unit {
        let dataShadow: BZip2OutputStreamData = this.data
        let pos: Array<Byte> = dataShadow.sendMTFValues2_pos

        for (i in nGroups - 1..=0 : -1) {
            pos[i] = UInt8(i & 0xff)
        }

        for (i in 0..nSelectors) {
            let ll_i: Byte = dataShadow.selector[i]
            var tmp: Byte = pos[0]
            var j: Int64 = 0

            while (ll_i != tmp) {
                j++
                let tmp2: Byte = tmp
                tmp = pos[j]
                pos[j] = tmp2
            }

            pos[0] = tmp
            dataShadow.selectorMtf[i] = UInt8(j & 0xff)
        }
    }
