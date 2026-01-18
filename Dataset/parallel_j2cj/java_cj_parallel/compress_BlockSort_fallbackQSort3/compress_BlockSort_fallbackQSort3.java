    private void fallbackQSort3(final int[] fmap, final int[] eclass, final int loSt, final int hiSt) {
        int lo, unLo, ltLo, hi, unHi, gtHi, n;

        long r = 0;
        int sp = 0;
        fpush(sp++, loSt, hiSt);

        while (sp > 0) {
            final int[] s = fpop(--sp);
            lo = s[0];
            hi = s[1];

            if (hi - lo < FALLBACK_QSORT_SMALL_THRESH) {
                fallbackSimpleSort(fmap, eclass, lo, hi);
                continue;
            }

            /*
             * LBZ2: Random partitioning. Median of 3 sometimes fails to avoid bad cases. Median of 9 seems to help but looks rather expensive. This too seems
             * to work but is cheaper. Guidance for the magic constants 7621 and 32768 is taken from Sedgewick's algorithms book, chapter 35.
             */
            r = (r * 7621 + 1) % 32768;
            final long r3 = r % 3;
            final long med;
            if (r3 == 0) {
                med = eclass[fmap[lo]];
            } else if (r3 == 1) {
                med = eclass[fmap[lo + hi >>> 1]];
            } else {
                med = eclass[fmap[hi]];
            }

            unLo = ltLo = lo;
            unHi = gtHi = hi;

            // looks like the ternary partition attributed to Wegner
            // in the cited Sedgewick paper
            while (true) {
                while (true) {
                    if (unLo > unHi) {
                        break;
                    }
                    n = eclass[fmap[unLo]] - (int) med;
                    if (n == 0) {
                        fswap(fmap, unLo, ltLo);
                        ltLo++;
                        unLo++;
                        continue;
                    }
                    if (n > 0) {
                        break;
                    }
                    unLo++;
                }
                while (true) {
                    if (unLo > unHi) {
                        break;
                    }
                    n = eclass[fmap[unHi]] - (int) med;
                    if (n == 0) {
                        fswap(fmap, unHi, gtHi);
                        gtHi--;
                        unHi--;
                        continue;
                    }
                    if (n < 0) {
                        break;
                    }
                    unHi--;
                }
                if (unLo > unHi) {
                    break;
                }
                fswap(fmap, unLo, unHi);
                unLo++;
                unHi--;
            }

            if (gtHi < ltLo) {
                continue;
            }

            n = Math.min(ltLo - lo, unLo - ltLo);
            fvswap(fmap, lo, unLo - n, n);
            int m = Math.min(hi - gtHi, gtHi - unHi);
            fvswap(fmap, unHi + 1, hi - m + 1, m);

            n = lo + unLo - ltLo - 1;
            m = hi - (gtHi - unHi) + 1;

            if (n - lo > hi - m) {
                fpush(sp++, lo, n);
                fpush(sp++, m, hi);
            } else {
                fpush(sp++, m, hi);
                fpush(sp++, lo, n);
            }
        }
    }
