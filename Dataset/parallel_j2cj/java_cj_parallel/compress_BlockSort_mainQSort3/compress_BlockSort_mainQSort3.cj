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