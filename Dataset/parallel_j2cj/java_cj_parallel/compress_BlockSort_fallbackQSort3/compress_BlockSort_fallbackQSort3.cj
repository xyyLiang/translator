    private func fallbackQSort3(fmap: Array<Int64>, eclass: Array<Int64>, loSt: Int64, hiSt: Int64): Unit {
        var (lo, unlo, ltlo, hi, unhi, gthi, n): (Int64, Int64, Int64, Int64, Int64, Int64, Int64)
        var (r, sp): (Int64, Int64) = (0, 0)
        fpush(sp, loSt, hiSt)
        sp++

        while (sp > 0) {
            sp--
            (lo, hi) = fpop(sp)

            if (hi - lo < FALLBACK_QSORT_SMALL_THRESH) {
                fallbackSimpleSort(fmap, eclass, lo, hi)
                continue
            }

            r = ((r * 7621) + 1) % 32768
            let r3: Int64 = r % 3
            let med: Int64 = match (r3) {
                case 0 => eclass[fmap[lo]]
                case 1 => eclass[fmap[(lo + hi).unsignedRightShift(1)]]
                case _ => eclass[fmap[hi]]
            }

            (unlo, ltlo, unhi, gthi) = (lo, lo, hi, hi)

            while (true) {
                while (true) {
                    if (unlo > unhi) {
                        break
                    }
                    n = eclass[fmap[unlo]] - med
                    if (n == 0) {
                        fswap(fmap, unlo, ltlo)
                        ltlo++
                        unlo++
                        continue
                    }
                    if (n > 0) {
                        break
                    }
                    unlo++
                }
                while (true) {
                    if (unlo > unhi) {
                        break
                    }
                    n = eclass[fmap[unhi]] - med
                    if (n == 0) {
                        fswap(fmap, unhi, gthi)
                        gthi--
                        unhi--
                        continue
                    }
                    if (n < 0) {
                        break
                    }
                    unhi--
                }
                if (unlo > unhi) {
                    break
                }
                fswap(fmap, unlo, unhi)
                unlo++
                unhi--
            }

            if (gthi < ltlo) {
                continue
            }

            n = math.min(ltlo - lo, unlo - ltlo)
            fvswap(fmap, lo, unlo - n, n)
            var m: Int64 = math.min(hi - gthi, gthi - unhi)
            fvswap(fmap, unhi + 1, hi - m + 1, m)

            n = lo + unlo - ltlo - 1
            m = hi - (gthi - unhi) + 1

            if (n - lo > hi - m) {
                fpush(sp, lo, n)
                fpush(sp + 1, m, hi)
                sp += 2
            } else {
                fpush(sp, m, hi)
                fpush(sp + 1, lo, n)
                sp += 2
            }
        }
    }