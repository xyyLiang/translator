    func fallbackSort(fmap: Array<Int64>, block: Array<Byte>, nblock: Int64): Unit {
        ftabreuse[..] = 0
        let ftab: Array<Int64> = ftabreuse
        var (jval, kval): (Int64, Int64)
        let eclass: Array<Int64> = getEclass()

        for (i in 0..nblock) {
            eclass[i] = 0
        }

        for (i in 0..nblock) {
            ftab[Int64(block[i])] += 1
        }

        for (i in 1..257) {
            ftab[i] += ftab[i - 1]
        }

        for (i in 0..nblock) {
            jval = Int64(block[i])
            kval = ftab[jval] - 1
            ftab[jval] = kval
            fmap[kval] = i
        }
        let bitSet: BitSet = BitSet(64 + nblock)
        for (i in 0..256) {
            bitSet.set(ftab[i])
        }
        for (i in 0..32) {
            bitSet.set(nblock + 2 * i)
            bitSet.clear(nblock + 2 * i + 1)
        }

        // LBZ2: the log(N) loop
        fallbackSortlognLoop(kval, bitSet, eclass, nblock)
    }
    private func fallbackSortlognLoop(k: Int64, bitSet: BitSet, eclass: Array<Int64>, nblock: Int64): Unit {
        var (H, kval) = (1, k)
        while (true) {
            var jval = 0
            for (nb in 0..nblock) {
                if (bitSet.get(nb)) {
                    jval = nb
                }
                kval = fmap[nb] - H
                if (kval < 0) {
                    kval += nblock
                }
                eclass[kval] = jval
            }

            var (nNotDone, l, r) = (0, 0, -1)
            while (true) {
                // LBZ2: find the next non-singleton bucket
                kval = r + 1
                kval = bitSet.nextClearBit(kval)
                l = kval - 1
                if (l >= nblock) {
                    break
                }
                kval = bitSet.nextSetBit(kval + 1)
                r = kval - 1
                if (r >= nblock) {
                    break
                }

                // LBZ2: now [l, r] bracket current bucket
                if (r > l) {
                    nNotDone += (r - l + 1)
                    fallbackQSort3(fmap, eclass, l, r)

                    // LBZ2: scan bucket and generate header bits
                    var cc = -1
                    for (i in l..=r) {
                        let cc1 = eclass[fmap[i]]
                        if (cc != cc1) {
                            bitSet.set(i)
                            cc = cc1
                        }
                    }
                }
            }
            H *= 2
            if (H > nblock || nNotDone == 0) {
                break
            }
        }
    }