    void mainSort(final BZip2CompressorOutputStream.Data dataShadow, final int lastShadow) {
        final int[] runningOrder = this.mainSort_runningOrder;
        final int[] copy = this.mainSort_copy;
        final boolean[] bigDone = this.mainSort_bigDone;
        final int[] ftab = this.ftab;
        final byte[] block = dataShadow.block;
        final int[] fmap = dataShadow.fmap;
        final char[] quadrant = this.quadrant;
        final int workLimitShadow = this.workLimit;
        final boolean firstAttemptShadow = this.firstAttempt;

        // LBZ2: Set up the 2-byte frequency table
        Arrays.fill(ftab, 0);

        /*
         * In the various block-sized structures, live data runs from 0 to last+NUM_OVERSHOOT_BYTES inclusive. First, set up the overshoot area for block.
         */
        for (int i = 0; i < BZip2Constants.NUM_OVERSHOOT_BYTES; i++) {
            block[lastShadow + i + 2] = block[i % (lastShadow + 1) + 1];
        }
        for (int i = lastShadow + BZip2Constants.NUM_OVERSHOOT_BYTES + 1; --i >= 0;) {
            quadrant[i] = 0;
        }
        block[0] = block[lastShadow + 1];

        // LBZ2: Complete the initial radix sort:

        int c1 = block[0] & 0xff;
        for (int i = 0; i <= lastShadow; i++) {
            final int c2 = block[i + 1] & 0xff;
            ftab[(c1 << 8) + c2]++;
            c1 = c2;
        }

        for (int i = 1; i <= 65536; i++) {
            ftab[i] += ftab[i - 1];
        }

        c1 = block[1] & 0xff;
        for (int i = 0; i < lastShadow; i++) {
            final int c2 = block[i + 2] & 0xff;
            fmap[--ftab[(c1 << 8) + c2]] = i;
            c1 = c2;
        }

        fmap[--ftab[((block[lastShadow + 1] & 0xff) << 8) + (block[1] & 0xff)]] = lastShadow;

        /*
         * LBZ2: Now ftab contains the first loc of every small bucket. Calculate the running order, from smallest to largest big bucket.
         */
        for (int i = 256; --i >= 0;) {
            bigDone[i] = false;
            runningOrder[i] = i;
        }

        // h = 364, 121, 40, 13, 4, 1
        for (int h = 364; h != 1;) { // NOSONAR
            h /= 3;
            for (int i = h; i <= 255; i++) {
                final int vv = runningOrder[i];
                final int a = ftab[vv + 1 << 8] - ftab[vv << 8];
                final int b = h - 1;
                int j = i;
                for (int ro = runningOrder[j - h]; ftab[ro + 1 << 8] - ftab[ro << 8] > a; ro = runningOrder[j - h]) {
                    runningOrder[j] = ro;
                    j -= h;
                    if (j <= b) {
                        break;
                    }
                }
                runningOrder[j] = vv;
            }
        }

        /*
         * LBZ2: The main sorting loop.
         */
        for (int i = 0; i <= 255; i++) {
            /*
             * LBZ2: Process big buckets, starting with the least full.
             */
            final int ss = runningOrder[i];

            // Step 1:
            /*
             * LBZ2: Complete the big bucket [ss] by quicksorting any unsorted small buckets [ss, j]. Hopefully previous pointer-scanning phases have already
             * completed many of the small buckets [ss, j], so we don't have to sort them at all.
             */
            for (int j = 0; j <= 255; j++) {
                final int sb = (ss << 8) + j;
                final int ftab_sb = ftab[sb];
                if ((ftab_sb & SETMASK) != SETMASK) {
                    final int lo = ftab_sb & CLEARMASK;
                    final int hi = (ftab[sb + 1] & CLEARMASK) - 1;
                    if (hi > lo) {
                        mainQSort3(dataShadow, lo, hi, 2, lastShadow);
                        if (firstAttemptShadow && this.workDone > workLimitShadow) {
                            return;
                        }
                    }
                    ftab[sb] = ftab_sb | SETMASK;
                }
            }

            // Step 2:
            // LBZ2: Now scan this big bucket so as to synthesise the
            // sorted order for small buckets [t, ss] for all t != ss.

            for (int j = 0; j <= 255; j++) {
                copy[j] = ftab[(j << 8) + ss] & CLEARMASK;
            }

            for (int j = ftab[ss << 8] & CLEARMASK, hj = ftab[ss + 1 << 8] & CLEARMASK; j < hj; j++) {
                final int fmap_j = fmap[j];
                c1 = block[fmap_j] & 0xff;
                if (!bigDone[c1]) {
                    fmap[copy[c1]] = fmap_j == 0 ? lastShadow : fmap_j - 1;
                    copy[c1]++;
                }
            }

            for (int j = 256; --j >= 0;) {
                ftab[(j << 8) + ss] |= SETMASK;
            }

            // Step 3:
            /*
             * LBZ2: The ss big bucket is now done. Record this fact, and update the quadrant descriptors. Remember to update quadrants in the overshoot area
             * too, if necessary. The "if (i < 255)" test merely skips this updating for the last bucket processed, since updating for the last bucket is
             * pointless.
             */
            bigDone[ss] = true;

            if (i < 255) {
                final int bbStart = ftab[ss << 8] & CLEARMASK;
                final int bbSize = (ftab[ss + 1 << 8] & CLEARMASK) - bbStart;
                int shifts = 0;

                while (bbSize >> shifts > 65534) {
                    shifts++;
                }

                for (int j = 0; j < bbSize; j++) {
                    final int a2update = fmap[bbStart + j];
                    final char qVal = (char) (j >> shifts);
                    quadrant[a2update] = qVal;
                    if (a2update < BZip2Constants.NUM_OVERSHOOT_BYTES) {
                        quadrant[a2update + lastShadow + 1] = qVal;
                    }
                }
            }

        }
    }
