    void fallbackSort(final int[] fmap, final byte[] block, final int nblock) {
        final int[] ftab = new int[257];
        int H, i, j, k, l, r, cc, cc1;
        int nNotDone;
        final int nBhtab;
        final int[] eclass = getEclass();

        for (i = 0; i < nblock; i++) {
            eclass[i] = 0;
        }
        /*--
          LBZ2: Initial 1-char radix sort to generate
          initial fmap and initial BH bits.
          --*/
        for (i = 0; i < nblock; i++) {
            ftab[block[i] & 0xff]++;
        }
        for (i = 1; i < 257; i++) {
            ftab[i] += ftab[i - 1];
        }

        for (i = 0; i < nblock; i++) {
            j = block[i] & 0xff;
            k = ftab[j] - 1;
            ftab[j] = k;
            fmap[k] = i;
        }

        nBhtab = 64 + nblock;
        final BitSet bhtab = new BitSet(nBhtab);
        for (i = 0; i < 256; i++) {
            bhtab.set(ftab[i]);
        }

        /*--
          LBZ2: Inductively refine the buckets.  Kind-of an
          "exponential radix sort" (!), inspired by the
          Manber-Myers suffix array construction algorithm.
          --*/

        /*-- LBZ2: set sentinel bits for block-end detection --*/
        for (i = 0; i < 32; i++) {
            bhtab.set(nblock + 2 * i);
            bhtab.clear(nblock + 2 * i + 1);
        }

        /*-- LBZ2: the log(N) loop --*/
        H = 1;
        while (true) {

            j = 0;
            for (i = 0; i < nblock; i++) {
                if (bhtab.get(i)) {
                    j = i;
                }
                k = fmap[i] - H;
                if (k < 0) {
                    k += nblock;
                }
                eclass[k] = j;
            }

            nNotDone = 0;
            r = -1;
            while (true) {

                /*-- LBZ2: find the next non-singleton bucket --*/
                k = r + 1;
                k = bhtab.nextClearBit(k);
                l = k - 1;
                if (l >= nblock) {
                    break;
                }
                k = bhtab.nextSetBit(k + 1);
                r = k - 1;
                if (r >= nblock) {
                    break;
                }

                /*-- LBZ2: now [l, r] bracket current bucket --*/
                if (r > l) {
                    nNotDone += r - l + 1;
                    fallbackQSort3(fmap, eclass, l, r);

                    /*-- LBZ2: scan bucket and generate header bits-- */
                    cc = -1;
                    for (i = l; i <= r; i++) {
                        cc1 = eclass[fmap[i]];
                        if (cc != cc1) {
                            bhtab.set(i);
                            cc = cc1;
                        }
                    }
                }
            }

            H *= 2;
            if (H > nblock || nNotDone == 0) {
                break;
            }
        }
    }
