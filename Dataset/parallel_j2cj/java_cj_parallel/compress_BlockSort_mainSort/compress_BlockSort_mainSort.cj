    private func mainQSort3(loSt: Int64, hiSt: Int64, dSt: Int64, last: Int64): Unit {
        stack_ll[0] = loSt
        stack_hh[0] = hiSt
        stack_dd[0] = dSt

        var sp: Int64 = 0
        while (sp >= 0) {
            let lo: Int64 = stack_ll[sp]
            let hi: Int64 = stack_hh[sp]
            let d: Int64 = stack_dd[sp]

            if ((hi - lo < SMALL_THRESH) || (d > DEPTH_THRESH)) {
                if (mainSimpleSort(lo, hi, d, last)) {
                    return
                }
            } else {
                let d1: Int64 = d + 1
                let med: Int64 = med3(
                    Int64(block[fmap[lo] + d1]),
                    Int64(block[fmap[hi] + d1]),
                    Int64(block[fmap[(lo + hi).unsignedRightShift(1)] + d1])
                )

                var (unlo, unhi, ltlo, gthi): (Int64, Int64, Int64, Int64) = (lo, hi, lo, hi)

                while (true) {
                    while (unlo <= unhi) {
                        let n: Int64 = Int64(block[fmap[unlo] + d1]) - med
                        if (n == 0) {
                            let temp: Int64 = fmap[unlo]
                            fmap[unlo] = fmap[ltlo]
                            unlo++
                            fmap[ltlo] = temp
                            ltlo++
                        } else if (n < 0) {
                            unlo++
                        } else {
                            break
                        }
                    }

                    while (unlo <= unhi) {
                        let n: Int64 = Int64(block[fmap[unhi] + d1]) - med
                        if (n == 0) {
                            let temp: Int64 = fmap[unhi]
                            fmap[unhi] = fmap[gthi]
                            unhi--
                            fmap[gthi] = temp
                            gthi--
                        } else if (n > 0) {
                            unhi--
                        } else {
                            break
                        }
                    }

                    if (unlo > unhi) {
                        break
                    }
                    let temp: Int64 = fmap[unlo]
                    fmap[unlo] = fmap[unhi]
                    unlo++
                    fmap[unhi] = temp
                    unhi--
                }

                if (gthi < ltlo) {
                    stack_ll[sp] = lo
                    stack_hh[sp] = hi
                    stack_dd[sp] = d1
                } else {
                    var n: Int64 = math.min(ltlo - lo, unlo - ltlo)
                    vswap(fmap, lo, unlo - n, n)
                    var m: Int64 = math.min(hi - gthi, gthi - unhi)
                    vswap(fmap, unlo, hi - m + 1, m)

                    n = lo + unlo - ltlo - 1
                    m = hi - (gthi - unhi) + 1

                    (stack_ll[sp], stack_hh[sp], stack_dd[sp]) = (lo, n, d)
                    sp++

                    (stack_ll[sp], stack_hh[sp], stack_dd[sp]) = (n + 1, m - 1, d1)
                    sp++

                    (stack_ll[sp], stack_hh[sp], stack_dd[sp]) = (m, hi, d)
                }
                sp++
            }
            sp--
        }
    }

    func mainSort(lastShadow: Int64): Unit {
        // LBZ2: Set up the 2-byte frequency table
        ftab[..] = 0

        for (i in 0..BZip2Constants.NUM_OVERSHOOT_BYTES) {
            block[lastShadow + i + 2] = block[(i % (lastShadow + 1)) + 1]
        }
        quadrant[0..=lastShadow + BZip2Constants.NUM_OVERSHOOT_BYTES] = 0
        block[0] = block[lastShadow + 1]

        var c1: Int64 = mainSortC1(lastShadow)

        /*
         * LBZ2: Now ftab contains the first loc of every small bucket.
         * Calculate the running order, from smallest to largest big bucket.
         */
        for (i in 255..=0 : -1) {
            bigDone[i] = false
            runningOrder[i] = i
        }

        var h: Int64 = 364 // h = 364, 121, 40, 13, 4, 1
        while (h != 1) {
            h /= 3
            for (i in h..=255) {
                let vv: Int64 = runningOrder[i]
                let a: Int64 = ftab[(vv + 1) << 8] - ftab[vv << 8]
                let b: Int64 = h - 1
                var j: Int64 = i

                var ro: Int64 = runningOrder[j - h]
                while ((ftab[(ro + 1) << 8] - ftab[ro << 8]) > a) {
                    runningOrder[j] = ro
                    j -= h
                    if (j <= b) {
                        break
                    }
                    ro = runningOrder[j - h]
                }
                runningOrder[j] = vv
            }
        }

        mainSortingLoop(lastShadow, c1)
    }
    private func mainSortC1(lastShadow: Int64): Int64 {
        var c1: Int64 = Int64(block[0])
        for (i in 0..=lastShadow) {
            let c2: Int64 = Int64(block[i + 1])
            let ftabIndex: Int64 = (c1 << 8) + c2
            ftab[ftabIndex] += 1
            c1 = c2
        }

        for (i in 1..=65536) {
            ftab[i] += ftab[i - 1]
        }

        c1 = Int64(block[1])
        for (i in 0..lastShadow) {
            let c2: Int64 = Int64(block[i + 2])
            let ftabIndex: Int64 = (c1 << 8) + c2
            ftab[ftabIndex] -= 1
            fmap[ftab[ftabIndex]] = i
            c1 = c2
        }

        let index: Int64 = (Int64(block[lastShadow + 1]) << 8) + Int64(block[1])
        ftab[index] -= 1
        fmap[ftab[index]] = lastShadow
        return c1
    }

    /*
     * LBZ2: The main sorting loop.
     */
    private func mainSortingLoop(lastShadow: Int64, c1value: Int64) {
        var c1 = c1value

        for (i in 0..=255) {
            let ss: Int64 = runningOrder[i]

            /*
             * Step 1:
             * LBZ2: Complete the big bucket [ss] by quicksorting any unsorted small buckets [ss, j].
             * Hopefully previous pointer-scanning phases have already completed many of the small buckets [ss, j],
             * so we don't have to sort them at all.
             */
            mainSortingLoop1(lastShadow, ss)

            /*
             * Step 2:
             * LBZ2: Now scan this big bucket so as to synthesise the
             * sorted order for small buckets [t, ss] for all t != ss.
             */
            for (j in 0..=255) {
                copy[j] = ftab[(j << 8) + ss] & CLEARMASK
            }

            for (j in (ftab[ss << 8] & CLEARMASK)..(ftab[(ss + 1) << 8] & CLEARMASK)) {
                let fmap_j: Int64 = fmap[j]
                c1 = Int64(block[fmap_j])
                if (!bigDone[c1]) {
                    if (fmap_j == 0) {
                        fmap[copy[c1]] = lastShadow
                    } else {
                        fmap[copy[c1]] = fmap_j - 1
                    }
                    copy[c1] += 1
                }
            }

            for (j in 255..=0 : -1) {
                ftab[(j << 8) + ss] |= SETMASK
            }

            /*
             * Step 3:
             * LBZ2: The ss big bucket is now done.
             * Record this fact, and update the quadrant descriptors.
             * Remember to update quadrants in the overshoot area too, if necessary.
             * The "if (i < 255)" test merely skips this updating for the last bucket processed,
             * since updating for the last bucket is pointless.
             */
            bigDone[ss] = true

            if (i < 255) {
                let bbStart: Int64 = ftab[ss << 8] & CLEARMASK
                let bbSize: Int64 = (ftab[(ss + 1) << 8] & CLEARMASK) - bbStart
                var shifts: Int64 = 0

                while ((bbSize >> shifts) > 65534) {
                    shifts++
                }

                for (j in 0..bbSize) {
                    let a2update: Int64 = fmap[bbStart + j]
                    let qVal: UInt16 = UInt16(j >> shifts)
                    quadrant[a2update] = qVal
                    if (a2update < BZip2Constants.NUM_OVERSHOOT_BYTES) {
                        quadrant[a2update + lastShadow + 1] = qVal
                    }
                }
            }
        }
    }
    private func mainSortingLoop1(lastShadow: Int64, ss: Int64) {
        for (j in 0..=255) {
            let sb: Int64 = (ss << 8) + j
            let ftab_sb: Int64 = ftab[sb]
            if ((ftab_sb & SETMASK) != SETMASK) {
                let lo: Int64 = ftab_sb & CLEARMASK
                let hi: Int64 = (ftab[sb + 1] & CLEARMASK) - 1
                if (hi > lo) {
                    mainQSort3(lo, hi, 2, lastShadow)
                    if (firstAttemptShadow && (this.workDone > workLimitShadow)) {
                        return
                    }
                }
                ftab[sb] = ftab_sb | SETMASK
            }
        }
    }