    private boolean mainSimpleSort(final BZip2CompressorOutputStream.Data dataShadow, final int lo, final int hi, final int d, final int lastShadow) {
        final int bigN = hi - lo + 1;
        if (bigN < 2) {
            return this.firstAttempt && this.workDone > this.workLimit;
        }

        int hp = 0;
        while (INCS[hp] < bigN) {
            hp++;
        }

        final int[] fmap = dataShadow.fmap;
        final char[] quadrant = this.quadrant;
        final byte[] block = dataShadow.block;
        final int lastPlus1 = lastShadow + 1;
        final boolean firstAttemptShadow = this.firstAttempt;
        final int workLimitShadow = this.workLimit;
        int workDoneShadow = this.workDone;

        // Following block contains unrolled code which could be shortened by
        // coding it in additional loops.

        HP: while (--hp >= 0) {
            final int h = INCS[hp];
            final int mj = lo + h - 1;

            for (int i = lo + h; i <= hi;) {
                // copy
                for (int k = 3; i <= hi && --k >= 0; i++) {
                    final int v = fmap[i];
                    final int vd = v + d;
                    int j = i;

                    // for (int a;
                    // (j > mj) && mainGtU((a = fmap[j - h]) + d, vd,
                    // block, quadrant, lastShadow);
                    // j -= h) {
                    // fmap[j] = a;
                    // }
                    //
                    // unrolled version:

                    // start inline mainGTU
                    boolean onceRunned = false;
                    int a = 0;

                    HAMMER: while (true) {
                        if (onceRunned) {
                            fmap[j] = a;
                            if ((j -= h) <= mj) { // NOSONAR
                                break HAMMER;
                            }
                        } else {
                            onceRunned = true;
                        }

                        a = fmap[j - h];
                        int i1 = a + d;
                        int i2 = vd;

                        // following could be done in a loop, but
                        // unrolled it for performance:
                        if (block[i1 + 1] == block[i2 + 1]) {
                            if (block[i1 + 2] == block[i2 + 2]) {
                                if (block[i1 + 3] == block[i2 + 3]) {
                                    if (block[i1 + 4] == block[i2 + 4]) {
                                        if (block[i1 + 5] == block[i2 + 5]) {
                                            if (block[i1 += 6] == block[i2 += 6]) { // NOSONAR
                                                int x = lastShadow;
                                                X: while (x > 0) {
                                                    x -= 4;
                                                    if (block[i1 + 1] == block[i2 + 1]) {
                                                        if (quadrant[i1] == quadrant[i2]) {
                                                            if (block[i1 + 2] == block[i2 + 2]) {
                                                                if (quadrant[i1 + 1] == quadrant[i2 + 1]) {
                                                                    if (block[i1 + 3] == block[i2 + 3]) {
                                                                        if (quadrant[i1 + 2] == quadrant[i2 + 2]) {
                                                                            if (block[i1 + 4] == block[i2 + 4]) {
                                                                                if (quadrant[i1 + 3] == quadrant[i2 + 3]) {
                                                                                    if ((i1 += 4) >= lastPlus1) { // NOSONAR
                                                                                        i1 -= lastPlus1;
                                                                                    }
                                                                                    if ((i2 += 4) >= lastPlus1) { // NOSONAR
                                                                                        i2 -= lastPlus1;
                                                                                    }
                                                                                    workDoneShadow++;
                                                                                    continue X;
                                                                                }
                                                                                if (quadrant[i1 + 3] > quadrant[i2 + 3]) {
                                                                                    continue HAMMER;
                                                                                }
                                                                                break HAMMER;
                                                                            }
                                                                            if ((block[i1 + 4] & 0xff) > (block[i2 + 4] & 0xff)) {
                                                                                continue HAMMER;
                                                                            }
                                                                            break HAMMER;
                                                                        }
                                                                        if (quadrant[i1 + 2] > quadrant[i2 + 2]) {
                                                                            continue HAMMER;
                                                                        }
                                                                        break HAMMER;
                                                                    }
                                                                    if ((block[i1 + 3] & 0xff) > (block[i2 + 3] & 0xff)) {
                                                                        continue HAMMER;
                                                                    }
                                                                    break HAMMER;
                                                                }
                                                                if (quadrant[i1 + 1] > quadrant[i2 + 1]) {
                                                                    continue HAMMER;
                                                                }
                                                                break HAMMER;
                                                            }
                                                            if ((block[i1 + 2] & 0xff) > (block[i2 + 2] & 0xff)) {
                                                                continue HAMMER;
                                                            }
                                                            break HAMMER;
                                                        }
                                                        if (quadrant[i1] > quadrant[i2]) {
                                                            continue HAMMER;
                                                        }
                                                        break HAMMER;
                                                    }
                                                    if ((block[i1 + 1] & 0xff) > (block[i2 + 1] & 0xff)) {
                                                        continue HAMMER;
                                                    }
                                                    break HAMMER;

                                                }
                                                break HAMMER;
                                            } // while x > 0
                                            if ((block[i1] & 0xff) > (block[i2] & 0xff)) {
                                                continue HAMMER;
                                            }
                                            break HAMMER;
                                        }
                                        if ((block[i1 + 5] & 0xff) > (block[i2 + 5] & 0xff)) {
                                            continue HAMMER;
                                        }
                                        break HAMMER;
                                    }
                                    if ((block[i1 + 4] & 0xff) > (block[i2 + 4] & 0xff)) {
                                        continue HAMMER;
                                    }
                                    break HAMMER;
                                }
                                if ((block[i1 + 3] & 0xff) > (block[i2 + 3] & 0xff)) {
                                    continue HAMMER;
                                }
                                break HAMMER;
                            }
                            if ((block[i1 + 2] & 0xff) > (block[i2 + 2] & 0xff)) {
                                continue HAMMER;
                            }
                            break HAMMER;
                        }
                        if ((block[i1 + 1] & 0xff) > (block[i2 + 1] & 0xff)) {
                            continue HAMMER;
                        }
                        break HAMMER;

                    } // HAMMER
                      // end inline mainGTU

                    fmap[j] = v;
                }

                if (firstAttemptShadow && i <= hi && workDoneShadow > workLimitShadow) {
                    break HP;
                }
            }
        }

        this.workDone = workDoneShadow;
        return firstAttemptShadow && workDoneShadow > workLimitShadow;
    }
