    private func generateMTFValues(): Unit {
        var nInUseShadow: Int64 = 0
        for (i in 0..256) {
            if (inUse[i]) {
                unseqToSeq[i] = UInt8(nInUseShadow & 0xff)
                nInUseShadow++
            }
        }

        this.nInUse = nInUseShadow

        let eob: Int64 = nInUseShadow + 1
        mtfFreq[0..=eob] = 0

        for (i in nInUseShadow - 1..=0 : -1) {
            yy[i] = UInt8(i & 0xff)
        }

        var (wr, zPend): (Int64, Int64) = generateMTFValuesLoop()

        if (zPend > 0) {
            zPend--
            while (true) {
                let runab = match {
                    case (zPend & 1) == 0 => RUNA
                    case _ => RUNB
                }
                sfmap[wr] = UInt16(runab)
                wr++
                mtfFreq[runab] += 1

                if (zPend < 2) {
                    break
                }
                zPend = (zPend - 2) >> 1
            }
        }

        sfmap[wr] = UInt16(eob)
        mtfFreq[eob] += 1
        this.nMTF = wr + 1
    }
    private func generateMTFValuesLoop(): (Int64, Int64) {
        var (wr, zPend): (Int64, Int64) = (0, 0)

        for (i in 0..=lastShadow) {
            let ll_i: Byte = unseqToSeq[block[fmap[i]]]
            var tmp: Byte = yy[0]
            var j: Int64 = 0

            while (ll_i != tmp) {
                j++
                let tmp2: Byte = tmp
                tmp = yy[j]
                yy[j] = tmp2
            }
            yy[0] = tmp

            if (j == 0) {
                zPend++
            } else {
                if (zPend > 0) {
                    zPend--
                    while (true) {
                        let runab = match {
                            case (zPend & 1) == 0 => RUNA
                            case _ => RUNB
                        }
                        sfmap[wr] = UInt16(runab)
                        wr++
                        mtfFreq[runab] += 1

                        if (zPend < 2) {
                            break
                        }
                        zPend = (zPend - 2) >> 1
                    }
                    zPend = 0
                }
                sfmap[wr] = UInt16(j + 1)
                wr++
                mtfFreq[j + 1] += 1
            }
        }
        (wr, zPend)
    }