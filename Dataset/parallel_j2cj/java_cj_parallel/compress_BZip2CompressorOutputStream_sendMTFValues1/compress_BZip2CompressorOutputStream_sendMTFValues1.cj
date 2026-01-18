    private func sendMTFValues1(nGroups: Int64, alphaSize: Int64): Int64 {
        let dataShadow: BZip2OutputStreamData = this.data
        let rfreq: Array<Array<Int64>> = dataShadow.sendMTFValues_rfreq
        let fave: Array<Int64> = dataShadow.sendMTFValues_fave
        let cost: Array<UInt16> = dataShadow.sendMTFValues_cost
        let sfmap: Array<UInt16> = dataShadow.sfmap
        let selector: Array<Byte> = dataShadow.selector
        let len: Array<Array<Byte>> = dataShadow.sendMTFValues_len
        let (len_0, len_1, len_2, len_3, len_4, len_5) = (len[0], len[1], len[2], len[3], len[4], len[5])
        let nMTFShadow: Int64 = this.nMTF

        var nSelectors: Int64 = 0

        for (_ in 0..N_ITERS) {
            for (t in nGroups - 1..=0 : -1) {
                fave[t] = 0
                let rfreqt: Array<Int64> = rfreq[t]
                for (i in alphaSize - 1..=0 : -1) {
                    rfreqt[i] = 0
                }
            }

            nSelectors = 0
            var gs: Int64 = 0
            while (gs < this.nMTF) {
                let ge: Int64 = math.min(gs + G_SIZE - 1, nMTFShadow - 1)
                if (nGroups == N_GROUPS) {
                    var (cost0, cost1, cost2, cost3, cost4, cost5) = (0u16, 0u16, 0u16, 0u16, 0u16, 0u16)
                    for (i in gs..=ge) {
                        let icv: Int64 = Int64(sfmap[i])
                        cost0 += UInt16(len_0[icv])
                        cost1 += UInt16(len_1[icv])
                        cost2 += UInt16(len_2[icv])
                        cost3 += UInt16(len_3[icv])
                        cost4 += UInt16(len_4[icv])
                        cost5 += UInt16(len_5[icv])
                    }
                    (cost[0], cost[1], cost[2], cost[3], cost[4], cost[5]) = (cost0, cost1, cost2, cost3, cost4, cost5)
                } else {
                    for (t in nGroups - 1..=0 : -1) {
                        cost[t] = 0
                    }
                    for (i in gs..=ge) {
                        let icv: Int64 = Int64(sfmap[i])
                        for (t in nGroups - 1..=0 : -1) {
                            cost[t] += UInt16(len[t][icv])
                        }
                    }
                }

                var (bt, bc): (Int64, Int64) = (0, 999999999)
                for (t in nGroups - 1..=0 : -1) {
                    let cost_t: Int64 = Int64(cost[t])
                    if (cost_t < bc) {
                        bc = cost_t
                        bt = t
                    }
                }

                fave[bt] += 1
                selector[nSelectors] = UInt8(bt & 0xff)
                nSelectors++
                let rfreq_bt: Array<Int64> = rfreq[bt]
                for (i in gs..=ge) {
                    rfreq_bt[Int64(sfmap[i])] += 1
                }
                gs = ge + 1
            }

            /*
             * Recompute the tables based on the accumulated frequencies.
             */
            for (t in 0..nGroups) {
                hbMakeCodeLengths(len[t], rfreq[t], this.data, alphaSize, 20)
            }
        }
        return nSelectors
    }
